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

    private let userService = UserService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        setupNavigationController()
        setUpTableView()
        presenter.displayBathActiveUser()
        presenter.displayWathActiveUser()
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
            presenter.makeBathActiveUser()
        case 1:
            presenter.makeWathActiveUser()
        default:
            break
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NameCell.self, for: indexPath)
        switch indexPath.section {
        case 0:
            if let isActiveBathUsers = presenter.isActiveBathUser {
                cell.setData(name: isActiveBathUsers[indexPath.row].name)
            }
        case 1:
            if let isActiveWathUser = presenter.isActiveWathUser {
                cell.setData(name: isActiveWathUser[indexPath.row].name)
            }
        default:
            break
        }
         return cell
    }
}
