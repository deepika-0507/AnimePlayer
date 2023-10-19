//
//  SearchViewModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 19/10/23.
//

import Foundation

class SearchViewModel: ObservableObject{
    @Published var animeList:[AnimeDataModel] = []
    var key: String = ""
    let apiService = ApiService()
    
    func getAnimeList() async throws {
        do {
            let animeList = try await apiService.getAnimeList(fromKey: key)
            DispatchQueue.main.async {
                self.animeList = animeList
            }
        } catch {
            print("error getting dat: \(error.localizedDescription)")
        }
    }
}
