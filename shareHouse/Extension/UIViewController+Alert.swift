//
//  UIViewController+Alert.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/03/27.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import UIKit

extension UIViewController {

    //MEMO:AlertActionが複数ある時に使用
    func showActionAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alret = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alret.addAction($0)}
        present(alret, animated: true)
    }

    //MEMO: Error部分のAlertの共通化
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { action in
            alert.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    //MEMO: Succes部分のAlertの共通化
    func showSuccesAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let doneaction = UIAlertAction(title: "完了", style: .default) { action in
            alert.dismiss(animated: true)
        }
        alert.addAction(doneaction)
        present(alert, animated: true)
    }
}
