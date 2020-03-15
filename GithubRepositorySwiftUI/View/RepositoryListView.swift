//
//  ContentView.swift
//  GithubRepositorySwiftUI
//
//  Created by Ivan Ruiz Monjo on 14/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct RepositoryListView: View {
    
    @ObservedObject var viewModel: RepositoryListViewModel
    
    var body: some View {
        VStack {
            TextField("Search...", text: $viewModel.searchText)
            List {
                if viewModel.isLoading {
                    Text("Loading...")
                } else {
                    ForEach(viewModel.repositories) { repo in
                        RepositoryRow(repository: repo)
                    }
                }
            }
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(viewModel: RepositoryListViewModel())
    }
}
