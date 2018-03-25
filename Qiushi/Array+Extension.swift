//
//  Array+Extension.swift
//  Qiushi
//
//  Created by MarvinX on 2018/3/23.
//  Copyright © 2018年 MarvinX. All rights reserved.
//

import Foundation
extension Array {
    func shuffle() -> Array {
        var list = self
        for index in 0..<list.count {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }

}
