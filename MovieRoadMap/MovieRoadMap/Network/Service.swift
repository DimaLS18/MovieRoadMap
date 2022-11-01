//
//  Service.swift
//  MovieRoadMap
//
//  Created by Dima Kovrigin on 26.10.2022.
//
import Foundation

// MARK: - Private Enum
enum PurchaseEndPoint: String {
    case link = "https://image.tmdb.org/t/p/w500"
    case popular = "/3/movie/popular"
    case topRated = "/3/movie/top_rated"
    case upcoming = "/3/movie/upcoming"
    case apiKey = "api_key"
    case language = "language"

}

/// Класс  отвечающий за загрузку даннных с сервера
final class Service {

    private lazy var session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()

    private let apiKey = "e81faf355027f9ca91258698400315ed"
    private var category = PurchaseEndPoint.popular

    static let shared = Service()

    func loadFilms(page: Int, completion: @escaping (Result) -> Void) {
        loadFilms(page: page, api: category, completion: completion)
    }

    func loadFilms(page: Int, api: PurchaseEndPoint, completion: @escaping (Result) -> Void) {
        category = api

        let queryItemKey = URLQueryItem(name: PurchaseEndPoint.apiKey.rawValue, value: apiKey)
        let queryItemLanguage = URLQueryItem(name: PurchaseEndPoint.language.rawValue, value: "ru-Ru")
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = api.rawValue
        components.queryItems = [queryItemKey, queryItemLanguage]
        guard let url = components.url else { return }
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                completion(result)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func loadFilm(index: Int, completion: @escaping (Film) -> Void) {
        let queryItemKey = URLQueryItem(name: "api_key", value: apiKey)
        let queryItemLanguage = URLQueryItem(name: "language", value: "ru-Ru")

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(index)"
        components.queryItems = [queryItemKey, queryItemLanguage]

        guard let url = components.url else { return }
        print(url)
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(Film.self, from: data)
                completion(result)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func loadVideos(index: Int, completion: @escaping ([VideoId]) -> Void) {
        let queryItemKey = URLQueryItem(name: "api_key", value: apiKey)
        let queryItemLanguage = URLQueryItem(name: "language", value: "ru-Ru")

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(index)/videos"
        components.queryItems = [queryItemKey, queryItemLanguage]

        guard let url = components.url else { return }
        print(url)
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(ResultVideos.self, from: data)
                completion(result.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
