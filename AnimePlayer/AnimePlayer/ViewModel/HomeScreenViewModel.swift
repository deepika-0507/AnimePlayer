//
//  HomeScreenViewModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    let apiService = ApiService()
    
    init() {
        Task { try await apiService.getAnimeForHomeScreen()}
    }
    
}
