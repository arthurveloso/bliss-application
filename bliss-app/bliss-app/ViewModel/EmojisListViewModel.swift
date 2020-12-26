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
    
    init(coordinator: HomeCoordinator, emojis: [String]) {
        self.coordinator = coordinator
        self.emojis = emojis
    }
}
