//
//  User.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/15.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import Firebase

struct User: FirestoreModelReadable, FirestoreModelWritable {
    
    enum  Field: String {
        case name
    }

    static var collectionRef: CollectionReference {
        return Firestore.firestore().collection("user")
    }

    var name: String = ""

    init(snapshot: DocumentSnapshot) {
        name = snapshot.stringValue(forKey: Field.name, default: "")
    }

    init(name: String) {
        self.name = name
    }

    var writeFields: [User.Field : Any] {
        return [.name: name]
    }
}
