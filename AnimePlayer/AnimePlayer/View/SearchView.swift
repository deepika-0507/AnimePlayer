//
//  SearchView.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 16/10/23.
//

import SwiftUI

struct SearchView: View {
    @State var searchedKey = ""
    @StateObject var viewModel = SearchViewModel()
    var body: some View {
        VStack {
            TextField("Search", text: $searchedKey)
                .border(.foreground)
                .padding()
                .onSubmit() {
                    viewModel.key = searchedKey
                    Task {
                        try await viewModel.fetchAnimeList()
                    }
                }
            List(viewModel.animeList, id: \.malId) { anime in
                Text("\(anime.title)")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
