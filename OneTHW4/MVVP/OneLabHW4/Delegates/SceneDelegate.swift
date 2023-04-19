//
//  SceneDelegate.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let factory = AppFactory()
        
        let appCoordinator = AppCoordinator(factory: factory)
        
        self.window = UIWindow(windowScene: windowScene)
        self.appCoordinator = appCoordinator
        
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
    }
}

