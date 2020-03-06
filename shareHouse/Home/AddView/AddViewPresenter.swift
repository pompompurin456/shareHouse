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
//        ここもっといい書き方がしたい。。。（抽象化したいんご）　＆　ユーザーが登録されていた場合の処理に関しても考えることが必要である。case文にしたい。。。
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously() { authResult, error in
                if let user = Auth.auth().currentUser {
                    let uid = user.uid
                    let firestoreUser = User.init(
                        name: name,
                        firebaseUid: uid,
                        activeBath: false,
                        activeWath: false
                    )

                    self.userService.createUser(user: firestoreUser) { result in
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
        } else if Auth.auth().currentUser != nil {
            print("もうおるで")
        }
    }
}

