//
//  HotCellNode.swift
//  Qiushi
//
//  Created by MarvinX on 2018/3/11.
//  Copyright © 2018年 MarvinX. All rights reserved.
//

import UIKit
import AsyncDisplayKit

//ion-male
//ion-female
class QiushiCellNode: ASCellNode {

    let avatarNode: NetImageNode = {
        let avatar = NetImageNode()
        avatar.cornerRadius = 17
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.placeholderFadeDuration = 3
        return avatar
    }()

    let likesNode = ASTextNode()

    let commentsNode = ASTextNode()

    let ganderNode = ASImageNode()

    let nicknameNode = ASTextNode()

    let ageNode = ASTextNode()

    let contentDescNode = ASTextNode()

    let contentImageNode: NetImageNode = {
        let contentNode = NetImageNode()
        contentNode.contentMode = .scaleAspectFill
        contentNode.placeholderFadeDuration = 3
        return contentNode
    }()

    var model:ItemsQuery.Data.Item.Row?

    init(model: ItemsQuery.Data.Item.Row) {
        super.init()
        self.model = model
        self.selectionStyle = .none
        if let avatar = model.avatar {
            self.avatarNode.url = URL.init(string: avatar)
        }else {
            self.avatarNode.url = URL.init(string: "https://static.qiushibaike.com/images/thumb/anony.png?v=b61e7f5162d14b7c0d5f419cd6649c87")
        }

        let ageAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.darkGray,
            NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)
        ]

        let likesAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)
        ]

        let nicknameAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.darkGray,
            NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)
        ]

        let contentAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.darkGray,
            NSAttributedStringKey.font:UIFont.italicSystemFont(ofSize: 15)
        ]

        ageNode.attributedText = NSAttributedString.init(string: "\(model.age!)", attributes: ageAttributes)

        if let nickname = model.nickname {
            self.nicknameNode.attributedText = NSAttributedString.init(string: nickname, attributes: nicknameAttributes)
        }else {
            self.nicknameNode.attributedText = NSAttributedString.init(string: "匿名用户", attributes: nicknameAttributes)
        }

        if model.gender! {
            ganderNode.image = UIImage.init(named: "male")
        }else {
            ganderNode.image = UIImage.init(named: "female")
        }

        if let contectText = model.contentText {
            self.contentDescNode.attributedText = NSAttributedString.init(string: contectText, attributes: contentAttributes)
        }

        if let contentImg = model.contentImg {
            self.contentImageNode.url = URL.init(string: contentImg)
        }

        self.likesNode.attributedText = NSAttributedString.init(string: "\(model.likes!)好笑", attributes: likesAttributes)

        self.commentsNode.attributedText = NSAttributedString.init(string: "\(model.comments!)评论", attributes: likesAttributes)


        self.automaticallyManagesSubnodes = true

    }
//布局
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        avatarNode.style.preferredSize = CGSize.init(width: 34, height: 34)

        let avatarInsetLayout = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0), child: avatarNode)

        let infoStackLayout = ASStackLayoutSpec()
        infoStackLayout.alignItems = .center
        infoStackLayout.direction = .horizontal
        infoStackLayout.spacing = 10
        infoStackLayout.children = [avatarInsetLayout,nicknameNode,ganderNode,ageNode]
        infoStackLayout.style.height = ASDimension.init(unit: .points, value: 49)

        let mainStackLayout = ASStackLayoutSpec.init()
        mainStackLayout.direction = .vertical

        mainStackLayout.children = [infoStackLayout]

        var contentDescLaout:ASInsetLayoutSpec
        if let _ = model?.contentText {
            contentDescLaout = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 8, 8, 8), child: contentDescNode)
            mainStackLayout.children?.append(contentDescLaout)
        }

        var contentImgLayout:ASInsetLayoutSpec
        if let _ = model?.contentImg, let ratio = model?.ratio {
            contentImgLayout = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(0, 0, 8, 0), child: ASRatioLayoutSpec.init(ratio: CGFloat(1.0/ratio), child: contentImageNode))
            mainStackLayout.children?.append(contentImgLayout)

        }

        let bottomStackLayout = ASStackLayoutSpec()
        bottomStackLayout.alignItems = .center
        bottomStackLayout.direction = .horizontal
        bottomStackLayout.spacing = 10
        bottomStackLayout.children = [likesNode,commentsNode]
        bottomStackLayout.style.height = ASDimension.init(unit: .points, value: 30)


        mainStackLayout.children?.append(ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0), child: bottomStackLayout))

        return mainStackLayout

    }

}
