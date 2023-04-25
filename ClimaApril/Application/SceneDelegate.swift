//
//  SceneDelegate.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: sceneWindow)
        window?.rootViewController = AssemblyModules(servicesAssembly: ServicesAssembly()).makeMainModule()
        window?.makeKeyAndVisible()
    }
}
