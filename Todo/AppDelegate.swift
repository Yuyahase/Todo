//
//  AppDelegate.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/03.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    //Tells the delegate that the launch process is almost done and the app is almost ready to run.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        //A container view controller that defines a stack-based scheme for navigating hierarchical content.
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        //Shows the window and makes it the key window.
        window?.makeKeyAndVisible()
        return true
    }
}

