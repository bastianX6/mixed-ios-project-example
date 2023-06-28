//
//  DetailViewReducer.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Foundation
import ReSwift

public class DetailViewReducer {
    weak var store: Store<DetailViewStateNew>?

    public init(store: Store<DetailViewStateNew>?) {
        self.store = store
    }

    public func detailViewReducer(_ action: Action, _ state: DetailViewStateNew?) -> DetailViewStateNew {
        var state = state ?? DetailViewStateNew()

        switch action {
        case let showErrorAction as DetailViewAction.ShowError:
            state.state = .withError(showErrorAction.error)
        case let showDataAction as DetailViewAction.ShowData:
            state.state = .withData(detailMovie: showDataAction.detailMovie)
        case let loadDataAction as DetailViewAction.LoadData:
            state.state = .loading
        case let setMovieAsFavoriteAction as DetailViewAction.SetMovieAsFavorite:
            let action = FavoriteMovieActions.SetFavoriteStatus(movie: setMovieAsFavoriteAction.movie,
                                                                willBeFavorite: setMovieAsFavoriteAction.movieIsFavorite,
                                                                favoritesProvider: setMovieAsFavoriteAction.favoritesProvider,
                                                                store: self.store)
            let favoritesReducer = FavoriteReducer()
            state.favoriteState = favoritesReducer.favoriteReducer(action, state.favoriteState)
        default:
            break
        }

        return state
    }
}
