//
//  HomeScreenViewModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    let apiService = ApiService()
    @Published var animeList: [AnimeDataModel] = []
    
//    init() {
//        Task { try await apiService.getAnimeForHomeScreen()}
//    }
    
    func getAnimeList() async throws {
        let animeList = try await apiService.getAnimeForHomeScreen(page: 1)
        
        DispatchQueue.main.async {
            self.animeList = animeList
        }
    }
    
}
