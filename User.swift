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
    let uuid: String
    
    init(name: String, uuid: String) {
        self.name = name
        self.uuid = uuid
    }
}
