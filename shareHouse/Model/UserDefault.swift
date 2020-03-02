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
        static let Name = "Name"
    }
}

extension UserData {
    static var Name: String? {
        get {
            return userDefault.string(forKey: Key.Name) ?? nil
        } set {
            userDefault.set(newValue, forKey: Key.Name)
            userDefault.synchronize()
        }
    }
}
