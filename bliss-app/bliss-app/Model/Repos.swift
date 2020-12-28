//
//  Repos.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 28/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import Foundation

struct Repos: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
