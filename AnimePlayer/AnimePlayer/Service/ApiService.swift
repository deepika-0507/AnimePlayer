//
//  ApiService.swift
//  AnimePlayer


//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import Foundation

class ApiService {
    let urlString = "https://api.jikan.moe/v4/anime"
    
    var overallData: [AnimeDataModel] = []
    
    func getAnimeForHomeScreen(page: Int) async throws -> [AnimeDataModel] {
        let urls = urlString+"?page=\(page)"
        guard let url = URL(string: urls) else {
            throw APIResponseErrors.missingUrlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw APIResponseErrors.reponseCodeError
        }
        
//        let dataString = String(decoding: data, as: UTF8.self)
//        print("Data: \(dataString)")
        
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
}

enum APIResponseErrors: Error {
    case missingUrlError
    case reponseCodeError
    case decodingError
}
