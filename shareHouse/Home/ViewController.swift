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

final class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!

    private let sectionTitle = ["お風呂", "洗濯機"]
    private let userService = UserService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        setupNavigationController()
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
}

extension ViewController: UITableViewDelegate {
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
        header.apply(text: sectionTitle[section])
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let firUser = Auth.auth().currentUser else { return }
        userService.getUser(firUid: firUser.uid) { result in
            switch result {
            case .success(let user):
                let alertController = UIAlertController(title: "君の名は", message: "あなたは\(user.name)ですか？", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "YES", style: .default) { action in
                    alertController.dismiss(animated: true)
                }

                alertController.addAction(okAction)
                self.present(alertController, animated: true)

            case .failure:
                let alertController = UIAlertController(title: "エラー", message: "登録されていません", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "かしこまりました", style: .default) { action in
                    alertController.dismiss(animated: true)
                }

                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }

        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NameCell.self, for: indexPath)
        return cell
    }
}
