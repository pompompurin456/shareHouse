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
    lazy var presenter: AddPresenter = AddViewPresenter()
    
    @IBOutlet weak var authenticationButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
                actionController.dismiss(animated: true)
            }
            actionController.addAction(cancelAction)
            self.present(actionController, animated: true)
        } else {
            print("error")
        }
    }
    
    private func uploadReportTroubleToFirestore() {
        let alertController = UIAlertController(title: "リクエストを送信", message: "ユーザーを登録しますか？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        let sendAction = UIAlertAction(title: "送信", style: .default) { _ in
            self.userResister()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(sendAction)
        
        present(alertController, animated: true)
    }
    
//    ここはくクラス名を変更の余地があり
    private func userResister() {
        
    }
    
    private func isBlankFieldExists() -> Bool {
        return nameTextField.text?.count == 0
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

extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
