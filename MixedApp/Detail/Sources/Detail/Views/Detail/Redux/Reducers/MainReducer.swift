//
//  MainReducer.swift
//
//
//  Created by bastian.veliz.vega on 10-02-22.
//

import Foundation
import ReSwift

class MainReducer {
    weak var store: Store<DetailViewStateNew>?

    func mainReducer(_ action: Action, _ state: DetailViewStateNew?) -> DetailViewStateNew {
        let reducer = DetailViewReducer(store: self.store).detailViewReducer(action, state)
        let favoriteState = FavoriteReducer().favoriteReducer(action, state?.favoriteState)
        return DetailViewStateNew(state: reducer.state,
                                  favoriteState: favoriteState)
    }
}
