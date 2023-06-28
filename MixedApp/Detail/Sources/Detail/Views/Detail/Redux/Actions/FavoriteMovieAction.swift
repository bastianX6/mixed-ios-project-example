//
//  FavoriteMovieAction.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Core
import Foundation
import ReSwift

enum FavoriteMovieActions {
    struct UpdateFavoriteStatus: Action {
        let isFavorite: Bool
    }

    struct ShowFavoriteMovieError: Action {
        let error: Error
        let movieWasFavorite: Bool
    }

    class SetFavoriteStatus: Action {
        private let movie: MovieModel
        let willBeFavorite: Bool
        private let favoritesProvider: FavoritesProviderProtocol
        private weak var store: Store<DetailViewStateNew>?

        init(movie: MovieModel,
             willBeFavorite: Bool,
             favoritesProvider: FavoritesProviderProtocol,
             store: Store<DetailViewStateNew>?)
        {
            self.movie = movie
            self.willBeFavorite = willBeFavorite
            self.favoritesProvider = favoritesProvider
            self.store = store
        }
    }
}

extension FavoriteMovieActions.SetFavoriteStatus {
    func addMovieAsFavorite() throws {
        try self.favoritesProvider.addAsFavorite(movie: self.movie)
    }

    func removeMovieAsFavorite() throws {
        try self.favoritesProvider.removeAsFavorite(movie: self.movie)
    }
}
