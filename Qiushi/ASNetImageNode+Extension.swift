//
//  ASNetImageNode+Extension.swift
//  Qiushi
//
//  Created by MarvinX on 2018/3/11.
//  Copyright © 2018年 MarvinX. All rights reserved.
//

import YYWebImage
import AsyncDisplayKit

extension ASNetworkImageNode {

    static func imageNode() -> ASNetworkImageNode {
        let manager = YYWebImageManager.shared()
        return ASNetworkImageNode.init(cache: manager, downloader: manager)
    }

}

extension YYWebImageManager: ASImageCacheProtocol, ASImageDownloaderProtocol {

    // mark -- ASImageDownloaderProtocol
    public func downloadImage(with URL: URL, callbackQueue: DispatchQueue, downloadProgress: AsyncDisplayKit.ASImageDownloaderProgress?, completion: @escaping AsyncDisplayKit.ASImageDownloaderCompletion) -> Any? {

        weak var operation: YYWebImageOperation?
        operation = requestImage(with: URL,
                                 options: .setImageWithFadeAnimation,
                                 progress: { (received, expected) -> Void in
                                    callbackQueue.async(execute: {
                                        let progress = expected == 0 ? 0 : received / expected
                                        downloadProgress?(CGFloat(progress))
                                    })
        }, transform: nil, completion: { (image, url, from, state, error) in
            completion(image, error, operation)
        })
        return operation
    }

    public func clearFetchedImageFromCache(with URL: URL) {

        let manager = YYWebImageManager.shared()
        if(manager.cache?.containsImage(forKey: URL.absoluteString, with: .memory))! {
//            print("从内存删除图片")
            manager.cache?.removeImage(forKey: URL.absoluteString, with: .memory)
        }
    }

    public func cancelImageDownload(forIdentifier downloadIdentifier: Any) {
        guard let operation = downloadIdentifier as? YYWebImageOperation else {
            return
        }
        operation.cancel()
    }

    // mark -- ASImageCacheProtocol
    public func cachedImage(with URL: URL, callbackQueue: DispatchQueue, completion: @escaping AsyncDisplayKit.ASImageCacherCompletion) {
        cache?.getImageForKey(cacheKey(for: URL), with: .all, with: { (image, cacheType) in
            callbackQueue.async {
                completion(image)
            }
        })
    }

}
