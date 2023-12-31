//
//  ApiService.swift
//  AnimePlayer


//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import Foundation

enum APIResponseErrors: Error {
    case missingUrlError
    case reponseCodeError
    case decodingError
}

class ApiService {
    
    static let shared = ApiService()
    
    let urlString = "https://api.jikan.moe/v4/anime"
    
    var overallData: [AnimeDataModel] = []
    var overAllRecomendedAnime: [EntryModel] = []
    
    func genericMethod<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIResponseErrors.missingUrlError
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw APIResponseErrors.reponseCodeError
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIResponseErrors.decodingError
        }
    }
}

extension ApiService {

    
    func getAnimeForHomeScreen(page: Int) async throws -> [AnimeDataModel] {
        let urls = urlString+"?page=\(page)"
        guard let url = URL(string: urls) else {
            throw APIResponseErrors.missingUrlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            if page > 1 {
                return overallData
            } else {
                throw APIResponseErrors.reponseCodeError
            }
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(AnimeListModel.self, from: data)
            overallData = overallData + decodedData.data
            if decodedData.pagination.hasNextPage && page < 3 {
                return try await getAnimeForHomeScreen(page: page+1)
            } else {
                return overallData
            }
        } catch {
            throw APIResponseErrors.decodingError
        }
    }
    
    func getAnimeList(fromKey key: String) async throws -> [AnimeDataModel] {
        let url = urlString+"?q=\(key)&sfw"
        guard let url = URL(string: url) else {
            throw APIResponseErrors.missingUrlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw APIResponseErrors.reponseCodeError
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(AnimeListModel.self, from: data)
            return decodedData.data
        } catch {
            throw APIResponseErrors.decodingError
        }
    }
    
    func getRecomendedAnimes() async throws -> [EntryModel] {
        let urlString = "https://api.jikan.moe/v4/recommendations/anime"
        guard let url = URL(string: urlString) else {
            throw APIResponseErrors.missingUrlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw APIResponseErrors.reponseCodeError
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(RecomendedAnimeListModel.self, from: data)
            for data in decodedData.data {
                overAllRecomendedAnime = overAllRecomendedAnime + data.entry
            }
            return overAllRecomendedAnime
        } catch {
            throw APIResponseErrors.decodingError
        }
    }
}
