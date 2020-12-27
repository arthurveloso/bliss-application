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
    let randomCachedEmoji = Bindable<Data?>(nil)
    
    let coordinator: HomeCoordinator
    let provider = MoyaProvider<GitHubService>()
    
    private var emojisList = [String]()
    private var cachedEmojis = [Emoji]()
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func getRandomEmoji() {
        cachedEmojis = CoreDataManager.shared.fetchImage()
        if cachedEmojis.isEmpty {
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
        } else {
            self.randomCachedEmoji.value = cachedEmojis.randomElement()?.image
        }
    }

    func goToEmojisList() {
        cachedEmojis = CoreDataManager.shared.fetchImage()
        coordinator.accept(step: .goToEmojisList(emojis: emojisList, emojisImage: cachedEmojis))
    }
    
    func goToAvatarsList() {
        coordinator.accept(step: .goToAvatarsList)
    }
    
    func goToAppleRepos() {
        coordinator.accept(step: .goToAppleRepos)
    }
    
    func searchUserAvatar(name: String) {
        provider.request(.getUser(name: name)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                
                break
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
