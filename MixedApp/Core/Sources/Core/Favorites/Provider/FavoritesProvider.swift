//
//  FavoritesProvider.swift
//
//
//  Created by bastian.veliz.vega on 30-04-21.
//

import Foundation

public protocol FavoritesProviderProtocol {
    func addAsFavorite(movie: MovieModel) throws
    func removeAsFavorite(movie: MovieModel) throws
    func getAllFavorites() throws -> [MovieModel]
}

public class FavoritesProvider: FavoritesProviderProtocol {
    private let service: FavoritesServiceProtocol

    public init(service: FavoritesServiceProtocol) {
        self.service = service
    }

    public func addAsFavorite(movie: MovieModel) throws {
        let entity = FavoriteMovieEntity(model: movie)
        try self.service.addAsFavorite(entity: entity)
    }

    public func removeAsFavorite(movie: MovieModel) throws {
        let entity = FavoriteMovieEntity(model: movie)
        try self.service.removeAsFavorite(entity: entity)
    }

    public func getAllFavorites() throws -> [MovieModel] {
        return try self.service.getAllFavorites().map { MovieModel(entity: $0) }
    }
}
