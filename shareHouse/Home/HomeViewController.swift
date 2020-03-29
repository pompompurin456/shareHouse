//
//  ViewController.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/08.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol HomeView: class {
    func showSuccesUpdateAlert()
    func showEroorUpdateAlert()
    func reloadTable()
}

final class HomeViewController: UIViewController, HomeView {
    lazy var presenter: HomePresenter = HomeViewPresenter(view: self)
    
    @IBOutlet weak var mainTableView: UITableView!

//    private var bathCellItem: [ActiveBathUser] = []
//    private var wathCellItem: [ActiveWathUser] = []
    private let userService = UserService()
    //    private let activeUser = ActiveUserService()
    var isActiveWathUser: [ActiveWathUser]?
    var isActiveBathUser: [ActiveBathUser]?
    var deletID = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        setupNavigationController()
        presenter.displayBathActiveUser()
        presenter.displayWathActiveUser()
        setUpTableView()
    }
    
    @objc private func presentAddView() {
        let addView = AddViewController.instantiate()
        let nextAddView = UINavigationController(rootViewController: addView)
        present(nextAddView, animated: true, completion: nil)
    }
    
    private func setupNavigationController() {
        let rigthButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.presentAddView))
        navigationItem.rightBarButtonItem = rigthButton
    }

    private func setUpTableView() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(cellType: NameCell.self)
        mainTableView.register(MyHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        mainTableView.tableFooterView = UIView()
    }

    func reloadTable() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }

    func showSuccesUpdateAlert() {
        let alertController = UIAlertController(title: "送信完了", message: "更新されました。", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "了解", style: .default) { action in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(doneAction)
        self.present(alertController, animated: true)
    }

    func showEroorUpdateAlert() {
        let alertController = UIAlertController(title: "送信失敗", message: "更新されませんでした。", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "了解", style: .default) { action in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    //ここのメソッド部分の認識が甘いから制御しているのかを考えて効果的に使っていくこと！！（特に高さに関する部分）
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55.0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MyHeaderView
        header.label.text = presenter.sections[section]
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("OK")
            //            presenter.deleteActiveBathUser()
        //            presenter.makeBathActiveUser()
        case 1:
            presenter.makeWathActiveUser()
        default:
            break
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if presenter.numberOfRowInSectionBath != 0 {
                return presenter.numberOfRowInSectionBath
            } else {
                return 5
            }
        case 1:
            if presenter.numberOfRowInSectionWath != 0 {
                return presenter.numberOfRowInSectionWath
            } else {
                return 5
            }
        default:
            return 5
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sections.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if editingStyle == UITableViewCell.EditingStyle.delete {
//                let bathCellItem = isActiveBathUser?[indexPath.row]
//                print(bathCellItem)
//                self.isActiveBathUser?.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                print("indexPath.item", indexPath.item)
                presenter.deleteActiveBathUser()
                print("Fuuu")
            }

        default:
            break
        }
    }
    //
    //        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //            let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
    //                guard let self = self  else {
    //                    return
    //                }
    //
    //                switch indexPath.section {
    //                case 0:
    //                    guard let cellItem = self.isActiveBathUser?[indexPath.row] else { return }
    //                    self.isActiveBathUser?.remove(at: indexPath.item)
    //                    tableView.deleteRows(at: [indexPath], with: .automatic)
    //                    self.presenter.deleteActiveBathUser(item: cellItem)
    //                    self.reloadTable()
    //                    print("できてる")
    //                default:
    //                    break
    //                }
    //            }
    //            let swipeAction = UISwipeActionsConfiguration(actions: [delete])
    //            swipeAction.performsFirstActionWithFullSwipe = false
    //            return swipeAction
    //        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NameCell.self, for: indexPath)
        switch indexPath.section {
        case 0:
            if presenter.numberOfRowInSectionBath != 0 {
                if let isActiveBathUsers = presenter.isActiveBathUser {
                    cell.setData(name: isActiveBathUsers[indexPath.row].name, number: String(indexPath.row + 1))
                }
                else if presenter.numberOfRowInSectionBath == 0 {
                    cell.setData(name: "誰もいないよ！", number: String(indexPath.row + 1))
                }
            }
        case 1:
            if presenter.numberOfRowInSectionWath != 0 {
                if let isActiveWathUser = presenter.isActiveWathUser {
                    cell.setData(name: isActiveWathUser[indexPath.row].name, number: String(indexPath.row + 1))

                } else if presenter.numberOfRowInSectionWath == 0 {
                    cell.setData(name: "誰もいないよ！", number: String(indexPath.row + 1))
                }
            }
        default:
            break
        }
        return cell
    }
}
