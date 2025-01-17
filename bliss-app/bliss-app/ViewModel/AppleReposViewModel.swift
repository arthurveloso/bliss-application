//
//  AppleReposViewModel.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 27/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import Foundation
import Moya

class AppleReposViewModel {
    
    let repos = Bindable<[Repos]>([])
    var currentPage = 1
    private let size = 20

    func fetchRepos() {
        let provider = MoyaProvider<GitHubService>()
        provider.request(.getUserRepos(user: "apple")) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    // Parsing the dictionary of emojis
                    let obj = try response.map([Repos].self)
                    if !self.repos.value.isEmpty {
                        let newValues = self.repos.value + obj
                        self.repos.value = newValues
                    } else {
                        self.repos.value = obj
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
        repos.value = []
    }
}
