//
//  NetImageNode.swift
//  Qiushi
//
//  Created by MarvinX on 2018/3/11.
//  Copyright © 2018年 MarvinX. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import YYWebImage

class NetImageNode: ASDisplayNode {

    private var networkImageNode = ASNetworkImageNode.imageNode()
    private var imageNode = ASImageNode()

    var image: UIImage? {
        didSet {
            networkImageNode.image = image
        }
    }

    override var placeholderFadeDuration: TimeInterval {
        didSet {
            networkImageNode.placeholderFadeDuration = placeholderFadeDuration
        }
    }

    var defaultImage: UIImage? {
        didSet {
            networkImageNode.defaultImage = defaultImage
        }
    }

    var url: URL? {
        didSet {
            if (YYWebImageManager.shared().cache?.containsImage(forKey: (url?.absoluteString)!))! {
                imageNode.image = YYWebImageManager.shared().cache?.getImageForKey((url?.absoluteString)!)
            } else {
                networkImageNode.url = url
            }
        }
    }

    override init() {
        super.init()
        addSubnode(networkImageNode)
        addSubnode(imageNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        return ASInsetLayoutSpec(insets: .zero,
                                 child: networkImageNode.url == nil ? imageNode : networkImageNode)

    }

    public func addTarget(_ target: Any?, action: Selector, forControlEvents controlEvents: ASControlNodeEvent) {
        networkImageNode.addTarget(target, action: action, forControlEvents: controlEvents)
        imageNode.addTarget(target, action: action, forControlEvents: controlEvents)
    }

}
