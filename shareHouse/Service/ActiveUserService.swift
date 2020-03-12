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

    func getActiveBathUserReF(/*limit: Int,*/ completion: @escaping (Result<[ActiveBathUser]?, FirestoreError>) -> Void) {
        db.collection("activeBathUser").getDocuments { documents, error in
            if error != nil {
                completion(.failure(.other))
                return
            }

            var isActiveBathUsers: [ActiveBathUser] = []
            if let docs = documents?.documents {
                for doc in docs {
                    let isActive = try! Firestore.Decoder().decode(ActiveBathUser.self, from: doc.data())
                    isActiveBathUsers.append(isActive)
                }
                completion(.success(isActiveBathUsers))
            } else {
                completion(.success(nil))
            }
        }
    }

    func getActiveWathUser(/*limit: Int,*/ completiom: @escaping (Result<[ActiveWathUser]?, FirestoreError>)-> Void) {
        db.collection("activeWathUser").getDocuments { document, error in
            if error != nil {
                completiom(.failure(.other))
                return
            }

            var isActiveWathUsers: [ActiveWathUser] = []
            if let docs = document?.documents {
                for doc in docs {
                    let isActive = try! Firestore.Decoder().decode(ActiveWathUser.self, from: doc.data())
                    isActiveWathUsers.append(isActive)
                }
                completiom(.success(isActiveWathUsers))
            } else {
                completiom(.success(nil))
            }
        }
    }
}
