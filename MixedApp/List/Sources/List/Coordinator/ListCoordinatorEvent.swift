//
//  ListCoordinatorEvent.swift
//  
//
//  Created by bastian.veliz.vega on 04-02-22.
//

import Foundation
import Coordinator
import Core

public enum ListCoordinatorEvent: CoordinatorEvent {
    case goToDetail(movie: MovieModel)
}

public enum ListExternalCoordinatorEvent: CoordinatorEvent {
    case goToDetail(movie: MovieModel)
}
