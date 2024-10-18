//
//  SceneDelegate.swift
//  Assignment15
//
//  Created by Beka on 16.10.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let mainPage = CalculatorUI()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController(rootViewController: mainPage)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

