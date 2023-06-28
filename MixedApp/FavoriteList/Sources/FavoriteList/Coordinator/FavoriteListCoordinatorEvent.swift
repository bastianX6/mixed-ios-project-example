//
//  FavoriteListCoordinatorEvent.swift
//
//
//  Created by bastian.veliz.vega on 05-02-22.
//

import Coordinator
import Core
import Foundation

public enum FavoriteListCoordinatorEvent: CoordinatorEvent {
    case goToDetail(movie: MovieModel)
}

public enum FavoriteListExternalCoordinatorEvent: CoordinatorEvent {
    case goToDetail(movie: MovieModel)
}
