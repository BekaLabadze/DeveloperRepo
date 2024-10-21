//
//  SceneDelegate.swift
//  Assignment16
//
//  Created by Beka on 18.10.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        let planetsTableView = PlanetsTableView()
        window?.rootViewController = UINavigationController(rootViewController: planetsTableView)
        window?.makeKeyAndVisible()
    }
    
}
