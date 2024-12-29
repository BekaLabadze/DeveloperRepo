//
//  SceneDelegate.swift
//  WorkAssignment35
//
//  Created by Beka on 27.12.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}
