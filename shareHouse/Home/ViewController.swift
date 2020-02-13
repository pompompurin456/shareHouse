//
//  ViewController.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/08.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import UIKit
import FloatingPanel

final class ViewController: UIViewController {
    
    private var fpc: FloatingPanelController!
            
//    private lazy var fpc: FloatingPanelController = {
//        let fpc = FloatingPanelController()
//        fpc.delegate = self as? FloatingPanelControllerDelegate
//        fpc.surfaceView.backgroundColor = UIColor.white
//        fpc.surfaceView.cornerRadius = 10
//        fpc.surfaceView.shadowRadius = 2.0
//        fpc.surfaceView.shadowOffset = CGSize(width: 0, height: 0)
//        fpc.surfaceView.shadowOpacity = 0.5
//        fpc.surfaceView.borderWidth = 1.0 / traitCollection.displayScale
//        fpc.surfaceView.borderColor = UIColor.black.withAlphaComponent(0.2)
//        fpc.isRemovalInteractionEnabled = true
//        return fpc
//
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        setFPC()
        setupNavigationController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        fpc.removePanelFromParent(animated: false)
    }
    
    @objc private func presentAddView() {
        let addView = AddViewController.instantiate()
        navigationController?.pushViewController(addView, animated: false)
    }
    
    private func setupNavigationController() {
        let rigthButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.presentAddView))
        navigationItem.rightBarButtonItem = rigthButton
    }
    
    private func setFPC() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        let addViewController = AddViewController()
        fpc.set(contentViewController: addViewController)
        fpc.addPanel(toParent: self, belowView: nil, animated: false)
    }
}

//extension ViewController: FloatingPanelControllerDelegate {
//    func floatingPanel(_ vc: FloatingPanelController, shouldRecognizeSimultaneouslyWith gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return 
//    }
//}


//extension ViewController: FloatingPanelControllerDelegate {
//    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
//        return AddFloatingPanelLayout(width: self.view.bounds.width, height: self.view.bounds.height)
//    }
//
//    func floatingPanel(_ vc: FloatingPanelController, behaviorFor newCollection: UITraitCollection) -> FloatingPanelBehavior? {
//        return AddFloatingPanelLayout(width: 100, height: 100) as! FloatingPanelBehavior
//    }
//}
