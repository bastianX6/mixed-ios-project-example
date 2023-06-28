//
//  DetailViewStateNew.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Foundation
import ReSwift

// MARK: - Detail View

public struct DetailViewStateNew: StateType {
    enum State {
        case withData(detailMovie: DetailViewItem)
        case loading
        case withError(Error)
    }

    var state: State
    public var favoriteState: FavoriteState

    public init() {
        self.state = .loading
        self.favoriteState = .init(state: .movieIsNotFavorite)
    }

    init(state: State = .loading,
         favoriteState: FavoriteState)
    {
        self.state = state
        self.favoriteState = favoriteState
    }
}
