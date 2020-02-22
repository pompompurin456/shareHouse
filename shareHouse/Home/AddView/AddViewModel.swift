//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/14.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import FirebaseAuth

final class AddViewModel {
    func signUp(name: String, callback: @escaping(Result<(), Error>) -> Void) {
        if Auth.auth().currentUser != nil {
            return
        }

        Auth.auth().signInAnonymously { authDataResult, error in
            guard let user = authDataResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            }
        }
    }

