//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/03/03.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol HomePresenter: class {
    func setUserName()
    func createBathActiveUser(userName: String)
    func createWathActiveUser(userName: String)
    var sections: [String] { get }
}

enum HomeTableViewActiveCellType: Int {
    case activeBathCell
    case activeWathCell
}

final class HomeViewPresenter: HomePresenter {

    private weak var view: HomeView?
    let sections = ["お風呂", "洗濯機"]
    private var userService = UserService()
    private var activeUserService = ActiveUserService()
    var me: User?

    init(view: HomeView) {
        self.view = view
    }

    func createBathActiveUser(userName: String) {
        let activeBathUser = ActiveBathUser(name: userName)
        self.activeUserService.createActiveBathUser(isActiveUser: activeBathUser, completion: { result in
            switch result {
            case .success:
                // TODO:　アラートの処理を追加すること
                print("できてるよ")
            case .failure:
                print("Failed to update")
            }
        })
    }

    func createWathActiveUser(userName: String) {
        let activeWathUser = ActiveBathUser(name: userName)
        self.activeUserService.createActiveWathUser(isActiveUser: activeWathUser, completion: { result in
            switch result {
            case .success:
                // TODO:　アラートの処理を追加すること
                print("できているohuro")
            case .failure:
                print("Failed to update")
            }
        })
    }


    func setUserName() {
        guard let firUser = Auth.auth().currentUser else { return }
        userService.getUser(firUid: firUser.uid) { result in
            switch result {
            case .success(let user):
                // TODO:　アラートの処理を追加すること
                UserData.Name = user.name
            case .failure:
                self.view?.showEroorUpdateAlert()
            }
        }
    }
}
