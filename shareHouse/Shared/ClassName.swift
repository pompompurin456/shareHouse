//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/28.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
