//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/20.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation

struct UserData {
    static let userDefault = Foundation.UserDefaults.standard

    struct Key {
        static let ID = "ID"
    }
}

extension UserData {
    static var ID: String? {
        get {
            return userDefault.string(forKey: Key.ID) ?? nil
        } set {
            userDefault.set(newValue, forKey: Key.ID)
            userDefault.synchronize()
        }
    }
}
