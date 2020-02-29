//
//  User.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/15.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import Firebase

struct User: Codable {
    let name: String
    let firebaseUid: String

    init(name: String, firebaseUid: String) {
        self.name = name
        self.firebaseUid = firebaseUid
    }
}
