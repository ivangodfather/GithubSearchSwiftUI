//
//  RepositoryAPI.swift
//  GithubRepositorySwiftUI
//
//  Created by Ivan Ruiz Monjo on 14/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import Combine

final class RepositoryAPI {
    func get(query: String) -> AnyPublisher<[Repository], GithubError> {
        guard var urlComponents = URLComponents(string: "https://api.github.com/search/repositories") else {
            return Empty().eraseToAnyPublisher()
        }
        urlComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        guard let url = urlComponents.url else {
            return Fail(error: GithubError.unkown).eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ItemResponse<Repository>.self, decoder: JSONDecoder())
            .map(\.items)
            .mapError { error -> GithubError in
                return .unkown
            }
            .eraseToAnyPublisher()
    }
}
