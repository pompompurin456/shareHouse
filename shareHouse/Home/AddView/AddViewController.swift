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
    func dismissSignIn(with user: User)
    func showCreateUserFailedAlert()
}

final class AddViewController: UIViewController, AddView {
    lazy var presenter: AddPresenter = AddViewPresenter(view: self)
    
    @IBOutlet weak var authenticationButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "君の名は"
        
        setUoTextField()
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let userName = nameTextField.text else {
            self.showBlankAlert()
            return
        }
        presenter.registerUser(name: userName)
        print("押されたよ")
    }

    func setUoTextField() {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "ニックネームを入力")
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange() {
        if nameTextField.text != "" {
            authenticationButton.backgroundColor = UIColor.black
            authenticationButton.layer.borderColor = UIColor.white.cgColor
            authenticationButton.isEnabled = true
        }
    }

    //    アラート部分のコードの共通化をおこなうことが大切（参考にするものがたくさんある）
    func showBlankAlert() {
        let alertController = UIAlertController(title: "エラー", message: "未入力の項目があります。\n入力内容をご確認ください。", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            alertController.dismiss(animated: true)
        }

        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func dismissSignIn(with user: User) {
        self.dismiss(animated: true)
        print("できているよ")
    }

    func showCreateUserFailedAlert() {
        let alertController = UIAlertController(title: "エラー", message: "ユーザー登録できませんでした。\n入力内容を確認し、何度も登録に失敗する場合は時間をおいて再度お試しください。", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            alertController.dismiss(animated: true)
        }

        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
