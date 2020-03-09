//
//  User.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/15.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    let firebaseUid: String
    let activeBath: Bool
    let activeWath: Bool

    init(name: String, firebaseUid: String, activeBath: Bool, activeWath: Bool) {
        self.name = name
        self.firebaseUid = firebaseUid
        self.activeBath = false
        self.activeWath = false
    }
}
