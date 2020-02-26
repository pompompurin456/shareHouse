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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        setupNavigationController()
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
}
