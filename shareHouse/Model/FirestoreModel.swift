//
//  FirestoreModel.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/25.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import Firebase

struct Document<T: FirestoreModel> {
    var id: String {
        return ref.documentID
    }
    let ref: DocumentReference
    let data: T
}

struct User: FirestoreModel {
    let name: String
}
protocol FirestoreModel {
}

