//
//  CacheDataModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 17/10/23.
//
import Foundation

struct CacheDataModel: Codable {
    let key: String
    let value: Data
    let expirationDate: Date
}

extension CacheDataModel {
    func makeKey(apikey: String, params: String) -> String {
        return apikey + "_" + params
    }
    
    var isValidData: Bool {
        let currentDate = Calendar.current
        let difference = currentDate.dateComponents([.minute], from: self.expirationDate).minute ?? 0
        return difference <= 100
    }
}
