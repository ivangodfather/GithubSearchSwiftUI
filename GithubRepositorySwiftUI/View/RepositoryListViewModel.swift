//
//  RepositoryListViewModel.swift
//  GithubRepositorySwiftUI
//
//  Created by Ivan Ruiz Monjo on 14/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import Combine

final class RepositoryListViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var repositories = [Repository]()
    var subscriptions = Set<AnyCancellable>()
    
    let api = RepositoryAPI()
    var searchText = "" {
        didSet {
            searchTextPublisher.send(searchText)
        }
    }
    var searchTextPublisher = PassthroughSubject<String, Never>()
    
    init() {
        
        searchTextPublisher.map { _ in true }.assign(to: \.isLoading, on: self).store(in: &subscriptions)
        
        let repositories = searchTextPublisher
            .throttle(for: .seconds(2), scheduler: DispatchQueue.main, latest: true)
            .setFailureType(to: GithubError.self)
            .map(api.get)
            .switchToLatest()
            .eraseToAnyPublisher()
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .share()

            
            
        repositories.map { _ in false }.assign(to: \.isLoading, on: self).store(in: &subscriptions)
        repositories.assign(to: \.repositories, on: self).store(in: &subscriptions)
    }
    
}


