//
//  HomeCoordinator.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 23/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

enum HomeSteps {
    case goToEmojisList(emojis: [String])
    case goToAvatarsList
    case goToAppleRepos
    case dismiss
}

class HomeCoordinator: Coordinator {

    let navigationController: UINavigationController

    private var steps = Bindable<HomeSteps?>(nil)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        steps.bind(skip: true) { [weak self] step in
            guard let self = self, let step = step else { return }
            switch step {
            case .goToEmojisList(let emojis):
                self.goToEmojisList(emojis: emojis)
            case .goToAvatarsList:
                self.goToAvatarsList()
            case .goToAppleRepos:
                self.goToAppleReposList()
            case .dismiss:
                self.dismiss()
            }
        }
    }

    func accept(step: HomeSteps) {
        steps.value = step
    }

    func start() {
        let vm = HomeViewModel(coordinator: self)
        let vc = HomeViewController(title: "Home", viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToEmojisList(emojis: [String]) {
        let vm = EmojisListViewModel(coordinator: self, emojis: emojis)
        let vc = EmojisListViewController(title: "Emojis", viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToAvatarsList() {
        
    }
    
    func goToAppleReposList() {
        
    }
    
    func dismiss() {
        
    }
}
