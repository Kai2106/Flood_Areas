//
//  MessageManager.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import SwiftMessages

class MessageManager {
    static let shared = MessageManager()
    
    var sharedConfig: SwiftMessages.Config {
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: UIWindow.Level(rawValue: UIWindow.Level.statusBar.rawValue).rawValue))
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        config.preferredStatusBarStyle = .lightContent
        return config
    }
}

// MARK: - Message notify.
extension MessageManager {
    func showMessage(messageType type: Theme, withTitle title: String = "", message: String, completion: (() -> Void)? = nil, duration: SwiftMessages.Duration = .seconds(seconds: 4)) {
        
        var config = sharedConfig
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(type)
        view.button?.isHidden = true
        view.configureContent(title: title, body: message)
        view.configureDropShadow()
        config.duration = duration
        config.eventListeners = [{ event in
            switch event {
            case .didHide:
                completion?()
            default:
                break
            }}]
        
        SwiftMessages.show(config: config, view: view)
    }
}

