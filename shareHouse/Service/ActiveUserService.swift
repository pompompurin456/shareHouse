//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/03/06.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class ActiveUserService {
    let db = Firestore.firestore()

    func createActiveBathUser(isActiveUser: ActiveBathUser, completion: @escaping (Result<Bool, FirestoreError>) -> Void) {
        let docData = try! Firestore.Encoder().encode(isActiveUser)

        db.collection("activeBathUser").addDocument(data: docData) { error in
            if error != nil {
                completion(.failure(.writingFailed))
                return
            }
        }

        completion(.success(true))
    }

    func createActiveWathUser(isActiveUser: ActiveBathUser, completion: @escaping (Result<Bool, FirestoreError>) -> Void) {
        let docData = try! Firestore.Encoder().encode(isActiveUser)

        db.collection("activeWathUser").addDocument(data: docData) { error in
            if error != nil {
                completion(.failure(.writingFailed))
                return
            }
        }

        completion(.success(true))
    }
}
