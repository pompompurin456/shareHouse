//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/14.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

final class UserService {
    let db = Firestore.firestore()

    func createUser(user: User, completion: @escaping (Result<Bool, FirestoreError>) -> Void) {
        Auth.auth().signInAnonymously() { (authResult, error) in
            let docData = try! Firestore.Encoder().encode(user)

            self.db.collection("user").addDocument(data: docData) { error in
                if error != nil {
                    completion(.failure(.writingFailed))
                    return
                }
            }
        }
    }
}
