//
//  Owner.swift
//  GithubRepositorySwiftUI
//
//  Created by Ivan Ruiz Monjo on 14/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Owner: Codable {
    let id: Int
    let avatarURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
    }
    
}
