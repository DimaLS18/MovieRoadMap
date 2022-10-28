//
//  FilmInfo.swift
//  MovieRoadMap
//
//  Created by Dima Kovrigin on 26.10.2022.
//

import Foundation

/// Массив с фильмами
struct Result: Decodable {
    let results: [FilmInfo]
    let pageCount: Int

    enum CodingKeys: String, CodingKey {
        case results
        case pageCount = "total_pages"
    }
}
/// модель фильма для первого экрана
struct Film: Decodable {
    let id: Int
    let overview: String
    let poster: String
    let tagline: String
    let title: String
    let rate: Double
    let release: String
    let genres: [Genres]
    let runtime: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title

        case tagline
        case overview
        case genres
        case runtime
        case poster = "poster_path"
        case rate = "vote_average"
        case release = "release_date"
    }
}

/// Модель жанров
struct Genres: Decodable {
    let name: String
}



/// модель фильма для второго экрана 
struct FilmInfo: Decodable {
    let title: String
    let id: Int
    let overview: String
    let poster: String
    let rate: Double

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster = "poster_path"
        case rate = "vote_average"
    }
}

