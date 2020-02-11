//
//  Instantiatable.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/09.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import UIKit

protocol Instantiateble { }

extension UIViewController: Instantiateble { }

extension Instantiateble where Self: UIViewController {
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Couldn't find appropriate Storybaord or Initial ViewController.")
        }
        return controller
    }
}

extension Instantiateble where Self: UIView {
    static func instantiate() -> Self {
        guard let view = UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Couldn't find appropriate UIview or Initial CustomView.")
        }
        return view
    }
    
    func instantiateFromXib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        addSubview(view)
        // ここの箇所の処理は安易をしているのか？？
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
                addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[view]|",
                    options:NSLayoutConstraint.FormatOptions(rawValue: 0),
                    metrics:nil,
                    views: bindings))
                addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[view]|",
                    options:NSLayoutConstraint.FormatOptions(rawValue: 0),
                    metrics:nil,
                    views: bindings))
            }
        }

