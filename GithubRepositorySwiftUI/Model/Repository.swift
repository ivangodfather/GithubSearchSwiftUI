//
//  Repository.swift
//  GithubRepositorySwiftUI
//
//  Created by Ivan Ruiz Monjo on 14/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct ItemResponse<T: Codable>: Codable {
    let items: [T]
}

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let stars: Int
    let url: URL
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, owner
        case stars = "stargazers_count"
        case url = "html_url"
    }
}
