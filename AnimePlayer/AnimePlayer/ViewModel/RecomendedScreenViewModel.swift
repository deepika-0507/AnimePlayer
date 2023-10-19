//
//  RecomendedScreenViewModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 19/10/23.
//

import Foundation

class RecomendedScreenViewModel: ObservableObject {
    @Published var animeList:[EntryModel] = []
    let apiService = ApiService()
    
    func getAnimeList() async throws {
        do {
            let animeList = try await apiService.getRecomendedAnimes()
            DispatchQueue.main.async {
                self.animeList = animeList
            }
        } catch {
            print("error getting recomended animes: \(error.localizedDescription)")
        }
    }
}
