//
//  ActiveWathUser.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/03/09.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation

struct ActiveWathUser: Codable {
    let name: String
    let data: Date

    init(name: String) {
        self.name = name
        self.data = Date()
    }
}
