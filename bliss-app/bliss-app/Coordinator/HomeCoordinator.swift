//
//  HomeCoordinator.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 23/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vm = HomeViewModel()
        let vc = HomeViewController(title: "Home", viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
