//
//  CacheDataManager.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 17/10/23.
//

import Foundation

class CacheDataManager {
    
    func storeData(key: String, value: Data) {
        let cacheDataModel = CacheDataModel(key: key, value: value, expirationDate: Date())
        UserDefaults.standard.set(try? JSONEncoder().encode(cacheDataModel), forKey: key)
    }
    
    func retrieveData(key: String) -> Data? {
        let cachedData = UserDefaults.standard.data(forKey: key)
        guard let cachedData = cachedData else { return nil }
        do {
            let decodedData = try JSONDecoder().decode(CacheDataModel.self, from: cachedData)
            return decodedData.isValidData ? decodedData.value : nil
        } catch {
            print("error decosing data:\(error.localizedDescription)")
            return nil
        }
    }
}
