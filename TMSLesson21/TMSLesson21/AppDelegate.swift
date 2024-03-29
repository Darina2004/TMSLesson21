//
//  AppDelegate.swift
//  TMSLesson21
//
//  Created by Mac on 6.02.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
           let viewController = ViewController()
           viewController.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
           viewController.view.backgroundColor = .white

           let navigationController = UINavigationController(rootViewController: viewController)

           navigationController.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
           navigationController.view.backgroundColor = .white

           window = UIWindow(frame: UIScreen.main.bounds)
           window?.rootViewController = navigationController
           window?.makeKeyAndVisible()

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

