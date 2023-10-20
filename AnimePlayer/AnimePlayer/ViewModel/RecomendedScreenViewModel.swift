//
//  RecomendedScreenViewModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 19/10/23.
//

import Foundation

class RecomendedScreenViewModel: ObservableObject, ViewModel {
    
    @Published var animeList:[EntryModel] = []
    let apiService = ApiService.shared
    
    func fetchAnimeList() async throws {
        do {
            let overAllList: RecomendedAnimeListModel = try await apiService.genericMethod(urlString: "https://api.jikan.moe/v4/recommendations/anime")
            var recomendedAnimes: [EntryModel] = []
            for data in overAllList.data {
                recomendedAnimes = recomendedAnimes + data.entry
            }
            DispatchQueue.main.async{
                self.animeList = recomendedAnimes
            }
        } catch {
            print("error getting recomended animes: \(error.localizedDescription)")
        }
    }
    
}

extension RecomendedScreenViewModel {
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
    
    func fetchRecomededAnimes() async throws {
        do {
            let overAllList: RecomendedAnimeListModel = try await apiService.genericMethod(urlString: "https://api.jikan.moe/v4/recommendations/anime")
            var recomendedAnimes: [EntryModel] = []
            for data in overAllList.data {
                recomendedAnimes = recomendedAnimes + data.entry
            }
            DispatchQueue.main.async{
                self.animeList = recomendedAnimes
            }
        } catch {
            print("error getting recomended animes: \(error.localizedDescription)")
        }
    }
}
