//
//  FavoritesService.swift
//
//
//  Created by bastian.veliz.vega on 30-04-21.
//

import Foundation

public protocol FavoritesServiceProtocol {
    func addAsFavorite(entity: FavoriteMovieEntity) throws
    func removeAsFavorite(entity: FavoriteMovieEntity) throws
    func getAllFavorites() throws -> [FavoriteMovieEntity]
}

public class FavoritesService: FavoritesServiceProtocol {
    private let cacheService: CacheServiceProtocol
    private let dispatchQueue = DispatchQueue(label: "read-save-data", attributes: .concurrent)

    public init(cacheService: CacheServiceProtocol) {
        self.cacheService = cacheService
        let emptyMovieList = FavoriteMovieList(movies: [])
        try? self.cacheService.createStorage(emptyMovieList, forKey: .favorites)
    }

    public func addAsFavorite(entity: FavoriteMovieEntity) throws {
        try self.dispatchQueue.sync(flags: .barrier) { [unowned self] in
            let favoriteMovies: FavoriteMovieList = try self.cacheService.readValue(forKey: .favorites)
            var movieList = favoriteMovies.movies
            movieList.append(entity)

            let newFavoriteMovies = FavoriteMovieList(movies: movieList)
            try self.cacheService.storeValue(newFavoriteMovies, forKey: .favorites)
        }
    }

    public func removeAsFavorite(entity: FavoriteMovieEntity) throws {
        try self.dispatchQueue.sync(flags: .barrier) { [unowned self] in
            let favoriteMovies: FavoriteMovieList = try self.cacheService.readValue(forKey: .favorites)
            var movieList = favoriteMovies.movies
            movieList.removeAll(where: { $0.id == entity.id })

            let newFavoriteMovies = FavoriteMovieList(movies: movieList)
            try self.cacheService.storeValue(newFavoriteMovies, forKey: .favorites)
        }
    }

    public func getAllFavorites() throws -> [FavoriteMovieEntity] {
        let favoriteMovies: FavoriteMovieList = try self.cacheService.readValue(forKey: .favorites)
        return favoriteMovies.movies
    }
}
