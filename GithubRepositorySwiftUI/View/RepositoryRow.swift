//
//  RepositoryRow.swift
//  GithubRepositorySwiftUI
//
//  Created by Ivan Ruiz Monjo on 15/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI
import Combine

struct RepositoryRow: View {
    
    let repository: Repository
    @ObservedObject var networkRequest: NetworkRequest<UIImage>
    
    init(repository: Repository) {
        self.repository = repository
        self.networkRequest = NetworkRequest<UIImage>(url: repository.owner.avatarURL, transform: { UIImage(data: $0) } )
    }
    
    var body: some View {
        HStack {
            Image(uiImage: networkRequest.result ?? UIImage())
                .resizable().frame(width: 64, height: 64)
            Spacer()
            VStack {
                Text(repository.name).font(Font.headline)
                HStack {
                    Image(systemName: "star.fill").foregroundColor(Color.yellow)
                    Text(" Stars: \(repository.stars.description)")
                }
            }
        }.onAppear { self.networkRequest.request() }
    }
}

final class NetworkRequest<T>: ObservableObject {
    
    @Published var result: T? = nil
    
    let url: URL
    let transform: (Data) -> T?
    
    
    init(url: URL, transform: @escaping (Data) -> T?) {
        self.url = url
        self.transform = transform
    }
    
    func request() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let object = self.transform(data) {
                    self.result = object
                }
            }
        }.resume()
    }
}
