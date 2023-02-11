//
//  AppDelegate.swift
//  FloodAreas
//
//  Created by KaiNgo on 06/02/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainVC = MainViewController()
        setRootViewController(mainVC)
        return true
    }
}

extension AppDelegate {
    
    /// Set app root view controller.
    /// - Parameter controller: UIViewController.
    func setRootViewController(_ controller: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        guard let window = appDelegate.window else { return }
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
        // A mask of options indicating how you want to perform the animations.
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        
        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.3
        
        // Creates a transition animation.
        // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
                            { completed in
            // Maybe do something on completion here
        })
    }
    
}

