//
//  SceneDelegate.swift
//  Test App For Anonym
//
//  Created by Тимур Фатулоев on 21.09.2020.
//  Copyright © 2020 Тимур Фатулоев. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .dark
        
        let navigationController = UINavigationController(
            rootViewController: MainViewController()
        )
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
    }

}
