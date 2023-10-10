//
//  ApiService.swift
//  AnimePlayer


//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import Foundation

class ApiService {
    let urlString = "https://api.jikan.moe/v4/anime"
    
    func getAnimeForHomeScreen() async throws -> [AnimeDataModel] {
        guard let url = URL(string: urlString) else {
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
            return decodedData.data
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
