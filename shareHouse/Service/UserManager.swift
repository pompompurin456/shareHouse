//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/14.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Firebase

final class UserManager {
    static let shared = UserManager()

    func signUp(withName name: String, completion: @escaping (Result<(), Error>) -> Void) {
        if Auth.auth().currentUser != nil {
            print("もういるよ。。。")
            return
        }

        Auth.auth().signInAnonymously { authDataResult, error in
            switch Result(authDataResult, error) {
                    case .success:
                        completion(.success(()))
                    case let .failure(error):
                        completion(.failure(error))
                    }
//            case let .failure(error):
//                completion(.failure(error))
            }
    }
}
