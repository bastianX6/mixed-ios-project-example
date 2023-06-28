//
//  FavoriteReducer.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Foundation
import ReSwift

public struct FavoriteReducer {
    public init() {}

    public func favoriteReducer(_ action: Action, _ state: FavoriteState?) -> FavoriteState {
        var state = state ?? FavoriteState()
        switch action {
        case let showErrorAction as FavoriteMovieActions.ShowFavoriteMovieError:
            state.state = .withError(error: showErrorAction.error,
                                     movieWasFavorite: showErrorAction.movieWasFavorite)
        case let updateFavoriteStatusAction as FavoriteMovieActions.UpdateFavoriteStatus:
            state.state = updateFavoriteStatusAction.isFavorite ? .movieIsFavorite : .movieIsNotFavorite
        case let setFavoriteStatusAction as FavoriteMovieActions.SetFavoriteStatus:
            if setFavoriteStatusAction.willBeFavorite {
                do {
                    try setFavoriteStatusAction.addMovieAsFavorite()
                    state.state = .movieIsFavorite
                } catch {
                    state.state = .withError(error: error, movieWasFavorite: !setFavoriteStatusAction.willBeFavorite)
                }
            } else {
                do {
                    try setFavoriteStatusAction.removeMovieAsFavorite()
                    state.state = .movieIsNotFavorite
                } catch {
                    state.state = .withError(error: error, movieWasFavorite: !setFavoriteStatusAction.willBeFavorite)
                }
            }
        default:
            break
        }

        return state
    }
}
