//
//  VideoID.swift
//  MovieRoadMap
//
//  Created by Dima Kovrigin on 28.10.2022.
//

import Foundation

/// Модель массива информации о видео
struct ResultVideos: Decodable {
    let results: [VideoId]
}

/// ключ от видео
struct VideoId: Decodable {
    let key: String
}
