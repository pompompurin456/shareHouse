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

                completion(.success(true))
            }
        }

        func getUser(firUid: String, completion: @escaping (Result<User, FirestoreError>) -> Void) {
            db.collection("user").whereField("firebaseUid", isEqualTo: firUid).getDocuments { snapshot, error in
                if error != nil {
                    completion(.failure(.other))
                    return
                }

                if let snapshot = snapshot {
                    switch snapshot.documents.count {
                    case 0:
                        completion(.failure(.documentNotFound))
                    case 1:
                        let data = snapshot.documents.first!.data()
                        let user = try! Firestore.Decoder().decode(User.self, from: data)
                        completion(.success(user))
                        print("completion", completion)
                    default:
                        completion(.failure(.documentDuplicated))
                    }
                } else {
                    completion(.failure(.documentNotFound))
                }
            }
        }

        func updateActiveWath(firUid: String, isActiveWath: Bool, completion: @escaping (Result<Bool, FirestoreError>) -> Void) {
            db.collection("user").whereField("firebaseUid", isEqualTo: firUid).getDocuments { snapshot, error in
                if error != nil {
                    completion(.failure(.other))
                    return
                }

                var documetReF: DocumentReference? = nil
                if let snapshot = snapshot {
                    switch snapshot.documents.count {
                    case 0:
                        completion(.failure(.documentNotFound))
                    case 1:
                        documetReF = snapshot.documents.first?.reference
                    default:
                        completion(.failure(.documentDuplicated))
                    }
                }

                if let deviceRef = documetReF {
                    deviceRef.updateData(["activeBath": isActiveWath]) { error in
                        if error != nil {
                            completion(.failure(.writingFailed))
                            return
                        }

                        completion(.success(true))
                    }
                }
            }
        }
    }
