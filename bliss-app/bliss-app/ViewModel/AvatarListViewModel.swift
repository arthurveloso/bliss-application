//
//  AvatarListViewModel.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 27/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import Foundation

class AvatarListViewModel {
    
    let avatars = Bindable<[Avatar]>([])
    
    func fetchAvatars() {
        avatars.value = CoreDataManager.shared.fetchAvatar()
    }
}
