//
//  HomeViewModel.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 24/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import Foundation
import Moya

class HomeViewModel {
    
    typealias Emoji = [String: String]
    
    let randomEmoji = Bindable<String?>(nil)
    
    let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func getRandomEmoji() {
        let provider = MoyaProvider<GitHubService>()
        provider.request(.getEmojis) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    // Parsing the dictionary of emojis
                    let obj = try response.map(Emoji.self)
                    
                    // TODO: Save it to Core Data
                    let randomEmoji = obj.randomElement()
                    self.randomEmoji.value = randomEmoji?.value
                } catch {
                    print("decoding error")
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func goToEmojisList() {
        coordinator.accept(step: .goToEmojisList)
    }
    
    func goToAvatarsList() {
        coordinator.accept(step: .goToAvatarsList)
    }
    
    func goToAppleRepos() {
        coordinator.accept(step: .goToAppleRepos)
    }
}
