//
//  HomeScreenViewModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import Foundation

class HomeScreenViewModel: ObservableObject, ViewModel {
    
    let apiService = ApiService.shared
    let cacheDataManager = CacheDataManager()
    @Published var animeList: [AnimeDataModel] = []
    
    func fetchAnimeList() async throws {
        do {
            let animeList: AnimeListModel = try await apiService.genericMethod(urlString: Constants.shared.BASE_PATH)
            DispatchQueue.main.async {
                self.animeList = animeList.data
            }
        } catch {
            print("error fetching data: \(error.localizedDescription)")
        }
    }
}

extension HomeScreenViewModel {
    
    //    init() {
    //        Task { try await apiService.getAnimeForHomeScreen()}
    //    }
    
    func getAnimeList() async throws {
        let animeList = try await apiService.getAnimeForHomeScreen(page: 1)
        
        DispatchQueue.main.async {
            self.animeList = animeList
        }
    }
    
    func getCachedOrLoadList() async throws {
        let cachedData = cacheDataManager.retrieveData(key: "anime_list_overall")
        
        if let cachedData = cachedData {
            do {
                let decodedData = try JSONDecoder().decode([AnimeDataModel].self, from: cachedData)
                DispatchQueue.main.async {
                    self.animeList = decodedData
                }
            } catch {
                throw APIResponseErrors.decodingError
            }
        } else {
            let animeList = try await apiService.getAnimeForHomeScreen(page: 1)
            do {
                let data = try JSONEncoder().encode(animeList)
                cacheDataManager.storeData(key: "anime_list_overall", value: data)
            } catch {
                throw APIResponseErrors.decodingError
            }
            DispatchQueue.main.async {
                self.animeList = animeList
            }
        }
    }
    
    func getDataFromGenericMethod() async throws {
        do {
            let animeList: AnimeListModel = try await apiService.genericMethod(urlString: Constants.shared.BASE_PATH)
            DispatchQueue.main.async {
                self.animeList = animeList.data
            }
        } catch {
            print("error fetching data: \(error.localizedDescription)")
        }
    }
}
