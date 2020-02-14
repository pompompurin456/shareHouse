//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/14.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import Firebase

struct Document<T, FirestoreModel> {
    var id: String {
        return ref.documentID
    }
    
    let ref: DocumentReference
    let data: T
    
    init(snapshot: DocumentSnapshot) {
        ref = snapshot.reference
        data = .init(snapshot: snapshot)
    }
}

protocol FirestoreModel {
    associatedtype Field: Hashable & RawRepresentable
    init(snapshot: DocumentSnapshot)
    static var collectionRef: CollectionReference { get }
    static func subCollectionRef(of document: DocumentReference) -> CollectionReference
}

