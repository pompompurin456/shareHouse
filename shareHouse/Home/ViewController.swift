//
//  ViewController.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/08.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import UIKit
import Foundation

final class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!

    let sectionTitle = ["お風呂", "洗濯機"]

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
        mainTableView.register(cellType: NameCell.self)
        mainTableView.tableFooterView = UIView()
    }
}

//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44.0
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44.0
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MyHeaderView
//        header.apply(text: sectionTitle[section])
//        return header
//    }
//}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NameCell.self, for: indexPath)
        return cell
    }
}
