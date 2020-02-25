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

    init(snapshot: DocumentSnapshot) {
        ref = snapshot.reference
        data = .init(snapshot: snapshot)
    }
}

protocol FirestoreModel {
    associatedtype Field: Hashable & RawRepresentable
    init(snapshot: DocumentSnapshot)
    static var collectionRef: CollectionReference { get }
}

protocol FirestoreModelReadable: FirestoreModel {}

protocol FirestoreModelWritable: FirestoreModel {
    var writeFields: [Field: Any] { get }
}


extension Document where T: FirestoreModelWritable, T.Field.RawValue == String {
    static func create(documentId: String? = nil, model: T, completion: @escaping (Result<(), Error>) -> Void) {
        let documentRef = documentId.map { T.collectionRef.document($0) } ?? T.collectionRef.document()
        documentRef.setData(model.writeFields.reduce(into: [:]) { $0[$1.key.rawValue] = $1.value }) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
