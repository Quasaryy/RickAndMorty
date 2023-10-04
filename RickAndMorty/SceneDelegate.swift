//
//  SceneDelegate.swift
//  RickSndMorty
//
//  Created by Yury on 19/08/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

          guard let windowScene = (scene as? UIWindowScene) else { return }

          window = UIWindow(frame: UIScreen.main.bounds)
          let viewController = UINavigationController(rootViewController: CollectionViewController())
          window?.rootViewController = viewController
          window?.makeKeyAndVisible()
          window?.windowScene = windowScene
        }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
