//
//  AppDelegate.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/08.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    var window: UIWindow?
//    var navigationController: UINavigationController?
//
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let viewController: ViewController = ViewController()
//        navigationController = UINavigationController(rootViewController: viewController)
//        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = navigationController
//        self.window?.makeKeyAndVisible()
//        
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db, "db")
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

