//
//  DetailViewAction.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Combine
import Core
import Foundation
import ReSwift

struct DetailViewAction {
    struct ShowError: Action {
        let error: Error
    }

    struct ShowData: Action {
        let detailMovie: DetailViewItem
    }

    class LoadData: Action {
        let movie: MovieModel
        let provider: GenresProviderProtocol
        let favoritesProvider: FavoritesProviderProtocol
        weak var store: Store<DetailViewStateNew>?
        var cancellables: ReferenceArray<AnyCancellable>

        init(movie: MovieModel,
             provider: GenresProviderProtocol,
             favoritesProvider: FavoritesProviderProtocol,
             store: Store<DetailViewStateNew>?,
             cancellables: inout ReferenceArray<AnyCancellable>)
        {
            self.movie = movie
            self.provider = provider
            self.favoritesProvider = favoritesProvider
            self.store = store
            self.cancellables = cancellables
        }
    }

    struct SetMovieAsFavorite: Action {
        let movie: MovieModel
        let favoritesProvider: FavoritesProviderProtocol
        let movieIsFavorite: Bool
    }
}
