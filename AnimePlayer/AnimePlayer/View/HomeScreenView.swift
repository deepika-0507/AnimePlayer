//
//  HomeScreenView.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 09/10/23.
//

import SwiftUI

struct HomeScreenView: View {
    @StateObject var viewModel = HomeScreenViewModel()
    
    var body: some View {
        List(viewModel.animeList, id: \.malId) { anime in
            Text("\(anime.title)")
        } .onAppear {
            Task { try await viewModel.getCachedOrLoadList() }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
