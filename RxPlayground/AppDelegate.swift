//
//  AppDelegate.swift
//  RxPlayground
//
//  Created by Jack Beoris on 1/30/19.
//  Copyright © 2019 Jack Beoris. All rights reserved.
//

import UIKit

enum RxPlaygroundType {
    case message
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let playgroundType: RxPlaygroundType = .message

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }

    func setupWindow() {
        let window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = getRootViewController()
        
        if self.window == nil {
            self.window = window
        }
        
        if let rootViewController = window.rootViewController {
            rootViewController.dismiss(animated: true, completion: {
                window.rootViewController = rootViewController
                window.makeKeyAndVisible()
            })
        } else {
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
    }
    
    func getRootViewController() -> UIViewController {
        switch playgroundType {
        case .message:
            return MessageViewController()
        }
    }

}

