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
    var maxApiCalls = 0
    
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
    
    
    func fetchAnimeListfromUrl() async throws {
        let cachedData = cacheDataManager.retrieveData(key: "anime_list_overall")
        
        if let cachedData = cachedData{
            do {
                let decodedData = try JSONDecoder().decode([AnimeDataModel].self, from: cachedData)
                DispatchQueue.main.async {
                    self.animeList = decodedData
                }
            } catch {
                throw APIResponseErrors.decodingError
            }
        } else {
            do {
                self.maxApiCalls += 1
                let animeList: AnimeListModel = try await apiService.genericMethod(urlString: Constants.shared.BASE_PATH)
                if animeList.pagination.hasNextPage, self.maxApiCalls <= 3 {
                    try await self.fetchAnimeList()
                }
                DispatchQueue.main.async {
                    self.animeList = self.animeList + animeList.data
                }
                if self.maxApiCalls > 3 {
                    do {
                        let data = try JSONEncoder().encode(self.animeList)
                        cacheDataManager.storeData(key: "anime_list_overall", value: data)
                    } catch {
                        throw APIResponseErrors.decodingError
                    }
                }
            } catch {
                print("error fetching data: \(error.localizedDescription)")
            }
        }
    }

    
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
