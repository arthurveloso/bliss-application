//
//  HomeViewModel.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 24/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import Foundation
import Moya

typealias Emojis = [String: String]

class HomeViewModel {

    let randomEmoji = Bindable<String?>(nil)
    
    let coordinator: HomeCoordinator
    
    private var emojisList = [String]()
    
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
                    let obj = try response.map(Emojis.self)
                    
                    // TODO: Save it to Core Data
                    let randomEmoji = obj.randomElement()
                    self.emojisList = Array(obj.values.map{ $0 })
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
        coordinator.accept(step: .goToEmojisList(emojis: emojisList))
    }
    
    func goToAvatarsList() {
        coordinator.accept(step: .goToAvatarsList)
    }
    
    func goToAppleRepos() {
        coordinator.accept(step: .goToAppleRepos)
    }
}
