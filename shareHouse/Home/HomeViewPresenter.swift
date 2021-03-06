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
    func makeBathActiveUser()
    func makeWathActiveUser()
    func displayBathActiveUser()
    func displayWathActiveUser()
    var sections: [String] { get }
    var isActiveBathUser: [ActiveBathUser]? { get }
    var isActiveWathUser: [ActiveWathUser]? { get }
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
    var isActiveWathUser: [ActiveWathUser]?
    var isActiveBathUser: [ActiveBathUser]?

    init(view: HomeView) {
        self.view = view
    }

    func displayBathActiveUser() {
        activeUserService.getActiveBathUserReF(/*limit: 5,*/ completion: { result in
            switch result {
            case .success(let isActiveUser):
                self.isActiveBathUser = isActiveUser
                self.view?.reloadTable()
                print(result, "result")
            case .failure:
                print("何様？？")
            }
        })
    }

    func displayWathActiveUser() {
        activeUserService.getActiveWathUser(completiom: { result in
            switch result {
            case .success(let isActiveUser):
                self.isActiveWathUser = isActiveUser
                self.view?.reloadTable()
            case .failure:
                print("ふざけるな")
            }
        })
    }

    func makeWathActiveUser() {
        guard let firUser = Auth.auth().currentUser else { return }
        userService.getUser(firUid: firUser.uid) { result in
            switch result {
            case .success(let user):
                self.createWathActiveUser(user: user)
            case .failure:
                print("error")
            }
        }
    }

    func makeBathActiveUser() {
        guard let firUser = Auth.auth().currentUser else { return }
        userService.getUser(firUid: firUser.uid) { result in
            switch result {
            case .success(let user):
                self.createBathActiveUser(user: user)
            case .failure:
                print("NO")
            }
        }
    }

    private func createBathActiveUser(user: User) {
        let activeBathUser = ActiveBathUser(name: user.name)
        self.activeUserService.createActiveBathUser(isActiveUser: activeBathUser, completion: { result in
            switch result {
            case .success:
                // TODO:　アラートの処理を追加すること
                print("result", result)
            case .failure:
                print("Failed to update")
            }
        })
    }

    func createWathActiveUser(user: User) {
        let activeWathUser = ActiveBathUser(name: user.name)
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
