//
//  SearchViewModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 19/10/23.
//

import Foundation

class SearchViewModel: ObservableObject, ViewModel {
    
    @Published var animeList:[AnimeDataModel] = []
    var key: String = ""
    let apiService = ApiService.shared
    
    func fetchAnimeList() async throws {
        let apikey = Constants.shared.BASE_PATH + "?q=\(self.key)&sfw"
        do {
            let overallList: AnimeListModel = try await apiService.genericMethod(urlString: apikey)
            DispatchQueue.main.async {
                self.animeList = overallList.data
            }
        } catch {
            print("error getting dat: \(error.localizedDescription)")
        }
    }
}

extension SearchViewModel {
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
    
    func fetchAnimeListFromGenericMethod() async throws {
        let apikey = Constants.shared.BASE_PATH + "?q=\(self.key)&sfw"
        do {
            let overallList: AnimeListModel = try await apiService.genericMethod(urlString: apikey)
            DispatchQueue.main.async {
                self.animeList = overallList.data
            }
        } catch {
            print("error getting dat: \(error.localizedDescription)")
        }
    }
}
