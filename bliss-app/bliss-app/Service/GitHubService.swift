//
//  GitHubService.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 24/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import Foundation
import Moya

enum GitHubService {
    case getEmojis
    case getUser(name: String)
    case getUserRepos(user: String)
}

extension GitHubService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getEmojis:
            return "/emojis"
        case .getUser(let user):
            return "/users/\(user)"
        case .getUserRepos(let user):
            return "/users/\(user)/repos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .getEmojis:
            return "{}".utf8Encoded
        case .getUser(_):
            return "{}".utf8Encoded
        case .getUserRepos(_):
            return "{}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .getEmojis, .getUser(_), .getUserRepos(_):
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
