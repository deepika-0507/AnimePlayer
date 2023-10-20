//
//  NewReleasesView.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 16/10/23.
//

import SwiftUI

struct NewReleasesView: View {
    @StateObject var viewModel = RecomendedScreenViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.animeList, id: \.malId) { anime in
                Text("\(anime.title)")
            }
            .navigationTitle("Recomended Animes")
        }
        .onAppear {
            Task { try await viewModel.fetchAnimeList() }
        }
        
    }
}

struct NewReleasesView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleasesView()
    }
}
