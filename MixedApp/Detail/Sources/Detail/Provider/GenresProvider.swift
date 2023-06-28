//
//  GenresProvider.swift
//
//
//  Created by bastian.veliz.vega on 24-04-21.
//

import Combine
import Core
import Foundation

protocol GenresProviderProtocol {
    func getGenres() -> AnyPublisher<[Int: String], Error>
}

class GenresProvider: GenresProviderProtocol {
    private let apiService: MovieDBCloudServiceProtocol
    private let cacheService: CacheServiceProtocol

    init(apiService: MovieDBCloudServiceProtocol,
         cacheService: CacheServiceProtocol)
    {
        self.apiService = apiService
        self.cacheService = cacheService
    }

    func getGenres() -> AnyPublisher<[Int: String], Error> {
        let publisher = self.readGenresFromCache()
            .catch { [unowned self] _ in
                // If cache reas fails, read genres from API
                self.readGenresFromApi()
                    .tryMap { response -> GenreListResponse in
                        // Try to store the genres in cache
                        try self.storeInCache(response: response)
                        return response
                    }
                    .map { response -> [Int: String] in
                        // Map response to a dictionary
                        var genreDict = [Int: String]()
                        response.genres.forEach { genreDict[$0.id] = $0.name }
                        return genreDict
                    }.eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        return publisher
    }

    private func storeInCache(response: GenreListResponse) throws {
        try self.cacheService.storeValue(response, forKey: .genres)
    }

    private func readGenresFromCache() -> AnyPublisher<[Int: String], Error> {
        let future = Future<[Int: String], Error> { promise in
            do {
                var genreDict = [Int: String]()
                let response: GenreListResponse = try self.cacheService.readValue(forKey: .genres)
                response.genres.forEach { genreDict[$0.id] = $0.name }
                promise(.success(genreDict))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()

        return future
    }

    private func readGenresFromApi() -> AnyPublisher<GenreListResponse, Error> {
        return self.apiService.getGenreList(language: nil).eraseToAnyPublisher()
    }
}
