//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/14.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseFirestore

final class AddViewModel {
    let db = Firestore.firestore()

    func createUser(user: User, completion: @escaping (Result<Bool, FirestoreError>) -> Void) {
        let docData = try! Firestore.Encoder().encode(user)

        db.collection("users").addDocument(data: docData) { error in
            if error != nil {
                completion(.failure(.writingFailed))
                return
            }
        }

        completion(.success(true))
    }
}
