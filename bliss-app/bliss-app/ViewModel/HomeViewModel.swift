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
        cachedEmojis = CoreDataManager.shared.fetchEmoji()
        if cachedEmojis.isEmpty {
            provider.request(.getEmojis) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(response):
                    do {
                        // Parsing the dictionary of emojis
                        let obj = try response.map(Emojis.self)
                        
                        // Getting random emoji
                        let randomEmoji = obj.randomElement()
                        self.randomEmoji.value = randomEmoji?.value
                        
                        // Saving all emojis to an in memory array
                        self.emojisList = Array(obj.values.map{ $0 })
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                case let .failure(error):
                    debugPrint(error.localizedDescription)
                }
            }
        } else {
            self.randomCachedEmoji.value = cachedEmojis.randomElement()?.image
        }
    }

    func searchUserAvatar(name: String) {
        provider.request(.getUser(name: name)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    let obj = try response.map(User.self)
                    self.saveUser(user: obj)
                } catch {
                    debugPrint(error.localizedDescription)
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func saveUser(user: User) {
        CoreDataManager.shared.saveAvatar(user: user)
    }

    func goToEmojisList() {
        cachedEmojis = CoreDataManager.shared.fetchEmoji()
        coordinator.accept(step: .goToEmojisList(emojis: emojisList, emojisImage: cachedEmojis))
    }
    
    func goToAvatarsList() {
        coordinator.accept(step: .goToAvatarsList)
    }
    
    func goToAppleRepos() {
        coordinator.accept(step: .goToAppleRepos)
    }
}
