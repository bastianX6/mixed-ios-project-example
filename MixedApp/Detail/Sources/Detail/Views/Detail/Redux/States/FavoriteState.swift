//
//  FavoriteState.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Foundation
import ReSwift

public struct FavoriteState: StateType {
    enum State {
        case movieIsFavorite
        case movieIsNotFavorite
        case withError(error: Error, movieWasFavorite: Bool)
    }

    var state: State

    public init() {
        self.state = .movieIsFavorite
    }

    init(state: State) {
        self.state = state
    }
}
