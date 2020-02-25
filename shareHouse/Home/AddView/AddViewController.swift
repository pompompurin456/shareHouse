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

protocol AddView: class {
}

final class AddViewController: UIViewController, AddView {
    //    lazy var presenter: AddPresenter = AddViewPresenter()
    
    @IBOutlet weak var authenticationButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登録画面"
        
        setUpButton()
        setNavigationBarButton()
        
        nameTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func authenticationButtonTapped(_ sender: Any) {
        if isBlankFieldExists() {
            let actionController = UIAlertController(title: "名前を入力してください", message: "登録には１文字以上必要です", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                actionController.dismiss(animated: true)
            }
            actionController.addAction(cancelAction)
            self.present(actionController, animated: true)
        } else {
            self.userCreate()
        }
    }

    private func userCreate() {
         let alertController = UIAlertController(title: "名前を送信", message: "ユーザーを登録しますか？？", preferredStyle: .alert)
               let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
                   alertController.dismiss(animated: true, completion: nil)
               }
               let sendAction = UIAlertAction(title: "送信", style: .default) { _ in
                   self.createUserPresent()
                print("ユーザに作ろう")
               }
               alertController.addAction(cancelAction)
               alertController.addAction(sendAction)

               present(alertController, animated: true)
           }
    private func createUserPresent() {
        guard let name = nameTextField.text else { return }
        print("真名の登録")
        UserManager.shared.signUp(withName: name) { result in
            print(result, "result")
        }
    }

    private func isBlankFieldExists() -> Bool {
        return nameTextField.text?.count == 0
    }

    private func setUpButton() {
        authenticationButton.layer.cornerRadius = 20
        authenticationButton.layer.borderWidth = 3
        authenticationButton.layer.borderColor = UIColor.black.cgColor
    }

    private func setNavigationBarButton() {
        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backViewController))
        navigationItem.leftBarButtonItem = leftButton
    }

    @objc private func backViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
