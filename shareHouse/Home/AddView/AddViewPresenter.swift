//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/29.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol AddPresenter {
    func registerUser(name: String)
}

final class AddViewPresenter: AddPresenter {
    private weak var view: AddView?
    private let userService = UserService()

    init(view:AddView) {
        self.view = view
    }

    func registerUser(name: String) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let firestoreUser = User.init(
                name: name,
                firebaseUid: uid
            )

            userService.createUser(user: firestoreUser) { result in
                print("result", result)
                switch result {
                case .success(_):
                    self.view?.dismissSignIn(with: firestoreUser)
                case .failure(_):
                    self.view?.showCreateUserFailedAlert()
                }
            }
        } else {
            self.view?.showCreateUserFailedAlert()
        }
    }
}

