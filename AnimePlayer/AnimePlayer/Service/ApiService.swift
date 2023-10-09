//
//  ApiService.swift
//  AnimePlayer


//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import Foundation

class ApiService {
    let urlString = "https://api.jikan.moe/v4/anime"
    
    func getAnimeForHomeScreen() async throws {
        guard let url = URL(string: urlString) else {
            print("url erroe")
            return
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            print("response error: \(response.statusCode)")
            return
        }
        
        let dataString = String(decoding: data, as: UTF8.self)
        
        print("Data: \(dataString)")
        
    }
}
