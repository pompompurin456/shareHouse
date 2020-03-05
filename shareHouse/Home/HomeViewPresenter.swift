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
    func updateActiveBathUser(isActiveBath: Bool)
}

enum HomeTableViewActiveCellType: Int {
    case activeBathCell
    case activeWathCell
}

final class HomeViewPresenter: HomePresenter {

    private weak var view: HomeView?
    private var userService = UserService()
    var me: User?

    init(view: HomeView) {
        self.view = view
    }

    func updateActiveBathUser(isActiveBath: Bool) {
        guard let firUser = Auth.auth().currentUser else { return }
        userService.updateActiveBath(firUid: firUser.uid, isActiveBath: isActiveBath) { result in
            switch result {
            case .success(_):
                self.view?.showSuccesUpdateAlert()
                print("Bathok")
            case .failure(_):
                self.view?.showEroorUpdateAlert()
                print("can not updateBath")
            }
        }
    }

    func updateActiveWath(isActiveWath: Bool) {
        guard let firUser = Auth.auth().currentUser else { return }
        userService.updateActiveWath(firUid: firUser.uid, isActiveWath: isActiveWath) { result in
            switch result {
            case .success(_):
                self.view?.showEroorUpdateAlert()
                print("WathOK")
            case .failure(_):
                self.view?.showEroorUpdateAlert()
                print("can not updateWath")
            }
        }
    }
}
