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
    
    func getRandomEmoji() {
        let provider = MoyaProvider<GitHubService>()
        provider.request(.getEmojis) { result in
            switch result {
            case let .success(response):
                do {
                    let obj = try response.map(Emoji.self)
                    print(obj)
                    
                } catch {
                    print("decoding error")
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
