//
//  AnimeListModel.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 09/10/23.
//

import Foundation

struct AnimeListModel: Codable {
    let data: [AnimeDataModel]
    let pagination: Pagination
}

struct Pagination: Codable {
    let hasNextPage: Bool
//    let currentPage: Int
}

struct AnimeDataModel: Codable {
    let malId: Int
    let url: String
    let images: ImageUrl
    let title: String
    let episodes: Int?
    let status: String
    let trailer: YoutubeUrl
}

struct ImageUrl: Codable {
    let jpg: JpgUrl
}

struct JpgUrl: Codable {
    let imageUrl: String
    let smallImageUrl: String
    let largeImageUrl: String
}

struct YoutubeUrl: Codable {
    let youtubeId: String?
    let url: String?
    let embedUrl: String?
}

struct RecomendedAnimeListModel: Codable {
    let pagination: Pagination
    let data: [RecomendedAnimeDataModel]
}

struct RecomendedAnimeDataModel: Codable {
    let malId: String
    let entry: [EntryModel]
    let user: UserModel?
}

struct EntryModel: Codable {
    let malId: Int
    let title: String
}

struct UserModel: Codable {
    let url: String
    let username: String
}
