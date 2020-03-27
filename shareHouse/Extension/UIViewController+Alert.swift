//
//  UIViewController+Alert.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/03/27.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import UIKit

extension UIViewController {
    func showActionAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated:  true)
    }

    func showAlert(title: String, message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(action)
        present(alert, animated:  true)
    }
}
