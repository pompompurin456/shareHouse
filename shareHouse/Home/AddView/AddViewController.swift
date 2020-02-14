//
//  HomeViewController.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/08.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import UIKit
import Firebase

final class AddViewController: UIViewController {
    
    @IBOutlet weak var authenticationButton: UIButton! {
        didSet {
            authenticationButton.isEnabled = false
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var name: String = "" {
        didSet {
            authenticationButton.isEnabled = !name.isEmpty
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登録画面"
        
        setUpButton()
        setNavigationBarButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    
    @IBAction func authenticationButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("ok")
    }
    
    private func setUpButton() {
        authenticationButton.layer.cornerRadius = 30
    }
    
    private func setNavigationBarButton() {
        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backViewController))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func backViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
