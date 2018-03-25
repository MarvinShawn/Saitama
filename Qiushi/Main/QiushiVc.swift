//
//  QiushiitemsVc.swift
//  Qiushi
//
//  Created by MarvinX on 2018/3/7.
//  Copyright © 2018年 MarvinX. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Apollo
enum ItemType:Int {
    case Hot = 0
    case New = 1
    case HotImage = 2
    case Text = 3
    case Pass = 4
    case QiuTu = 5
    case Fresh = 6
}

class QiushiVc: ASViewController<ASTableNode> {

    private let tabelNode = ASTableNode()
    private let refreshControl = UIRefreshControl()
    var currentPage = 1
    var items = [ItemsQuery.Data.Item.Row]()
    var type:ItemType = .Hot

    init(titie:String,type:ItemType) {
        super.init(node: tabelNode)
        configureTableNode()
        navigationItem.title = titie
        self.type = type
        tabelNode.delegate = self
        tabelNode.dataSource = self

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        tabelNode.leadingScreensForBatching = 2.5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    func loadData() {
        apollo.fetch(query: ItemsQuery(page: 1, pageNum: 10,type:self.type.rawValue), cachePolicy: .fetchIgnoringCacheData, queue: DispatchQueue.main) { [unowned self] (result, error) in
            if let error = error {
                self.refreshControl.endRefreshing()
                print("Erroe occur: \(error.localizedDescription)")
                return
            }
            self.items.removeAll()
            for row in (result?.data?.items?.rows)! {
                self.items.append(row!)
            }
            self.tabelNode.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    func configureTableNode() {

        //refreshControl
        refreshControl.tintColor = .gray

        if #available(iOS 10, *) {
            tabelNode.view.refreshControl = refreshControl
        }else {
            tabelNode.view.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tabelNode.view.tableFooterView = UIView()
    }

    @objc func refreshAction() {
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension QiushiVc: ASTableDelegate, ASTableDataSource {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {

        let cellNode = QiushiCellNode.init(model: self.items[indexPath.row])
        cellNode.neverShowPlaceholders = true
        return cellNode

    }

    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()

        apollo.fetch(query: ItemsQuery(page: currentPage, pageNum: 10,type:self.type.rawValue), cachePolicy: .fetchIgnoringCacheData, queue: DispatchQueue.main) { [unowned self] (result, error) in
            if let error = error {
                print("Erroe occur: \(error.localizedDescription)")
                return
            }
            if self.currentPage == 0 {
                self.items.removeAll()
            }
            for row in (result?.data?.items?.rows)! {
                self.items.append(row!)
            }
            if self.currentPage <= (result?.data?.items?.totalPages)! {
                self.currentPage += 1
            }
            self.insertNewRowsWithCount(count: (result?.data?.items?.rows?.count)!)
            context.completeBatchFetching(true)
        }
    }

    func insertNewRowsWithCount(count:Int) {

        var indePaths:[IndexPath] = [IndexPath]()
        let news = items.count
        for row in ((news - count)..<news) {
            let path = NSIndexPath.init(row: row, section: 0)
            indePaths.append(path as IndexPath)
        }
        tabelNode.insertRows(at: indePaths as [IndexPath], with: .none)
    }


}
