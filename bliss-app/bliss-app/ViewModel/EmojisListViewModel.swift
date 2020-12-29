//
//  EmojisListViewModel.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 26/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import Foundation
import Moya

class EmojisListViewModel {
    
    let coordinator: HomeCoordinator
    
    var emojis = [String]()
    var emojisImage = [Emoji]()
    
    var shouldFetchEmojis: Bool {
        emojisImage.isEmpty
    }
    
    let fetchedResult = Bindable<Bool>(false)
    
    init(coordinator: HomeCoordinator, emojis: [String], emojisImage: [Emoji]) {
        self.coordinator = coordinator
        self.emojis = emojis
        self.emojisImage = emojisImage
    }
    
    func fetchEmojis() {
        let provider = MoyaProvider<GitHubService>()
        provider.request(.getEmojis) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    // Parsing the dictionary of emojis
                    let obj = try response.map(Emojis.self)
                    self.emojis = Array(obj.values.map{ $0 })
                    self.fetchedResult.value = true
                } catch {
                    debugPrint(error.localizedDescription)
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func refreshData() {
        emojisImage = CoreDataManager.shared.fetchEmoji()
    }

    func saveImage(imageData: Data?) {
        guard let data = imageData else { return }
        CoreDataManager.shared.saveEmoji(data: data)
    }
}
