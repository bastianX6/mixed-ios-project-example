//
//  DetailViewModelStore.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Combine
import Core
import Foundation
import ReSwift

class DetailViewModelStore: ObservableObject {
    @Published var viewState: DetailViewStateNew = .init()

    private let movie: MovieModel
    private let genresProvider: GenresProviderProtocol
    private let favoritesProvider: FavoritesProviderProtocol
    private var cancellables: ReferenceArray<AnyCancellable> = .init()

    private weak var store: Store<DetailViewStateNew>?

    init(movie: MovieModel,
         genresProvider: GenresProviderProtocol,
         favoritesProvider: FavoritesProviderProtocol,
         store: Store<DetailViewStateNew>?)
    {
        self.movie = movie
        self.genresProvider = genresProvider
        self.favoritesProvider = favoritesProvider
        self.store = store
    }

    deinit {
        self.store?.unsubscribe(self)
    }

    func loadData() {
        let action = DetailViewAction.LoadData(movie: self.movie,
                                               provider: self.genresProvider,
                                               favoritesProvider: self.favoritesProvider,
                                               store: self.store,
                                               cancellables: &self.cancellables)
        self.store?.subscribe(self)
        self.store?.dispatch(action)
    }
}

extension DetailViewModelStore: StoreSubscriber {
    func newState(state: DetailViewStateNew) {
        self.viewState = state
    }
}
