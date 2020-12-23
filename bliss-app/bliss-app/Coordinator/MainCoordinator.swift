//
//  MainCoordinator.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 23/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    let navigationController: UINavigationController
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}
