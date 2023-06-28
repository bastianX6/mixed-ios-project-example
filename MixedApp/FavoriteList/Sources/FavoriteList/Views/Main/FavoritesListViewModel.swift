//
//  FavoritesListViewModel.swift
//
//
//  Created by bastian.veliz.vega on 16-05-21.
//

import Combine
import Core
import Foundation

protocol FavoritesListViewDelegate: AnyObject {
    func didTapCell(movie: MovieModel)
}

class FavoritesListViewModel: ObservableObject {
    @Published private(set) var viewState: ListViewState = .loading

    private var favoriteMovies: [MovieModel] = []
    private var cancellableArray: [AnyCancellable] = []
    private let favoritesProvider: FavoritesProviderProtocol
    weak var delegate: FavoritesListViewDelegate?

    init(favoritesProvider: FavoritesProviderProtocol) {
        self.favoritesProvider = favoritesProvider
    }

    func loadMovies() {
        let future = Future<[MovieModel], Error> { [weak self] promise in
            guard let self = self else { return }
            do {
                let favoriteMovies = try self.favoritesProvider.getAllFavorites()
                promise(.success(favoriteMovies))
            } catch {
                promise(.failure(error))
            }
        }

        future
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .finished:
                    self.updateView()
                case let .failure(error):
                    debugPrint("error: \(error)")
                    self.viewState = .error(error)
                }
            } receiveValue: { [weak self] favoriteMovies in
                guard let self = self else { return }
                self.favoriteMovies = favoriteMovies
            }
            .store(in: &self.cancellableArray)
    }

    private func updateView() {
        let data = self.favoriteMovies.map { FavoriteMovieCellModel(model: $0) }
        self.viewState = .withData(data)
    }

    func didTapCell(movie: MovieModel) {
        self.delegate?.didTapCell(movie: movie)
    }
}

enum ListViewState {
    case withData([FavoriteMovieCellModel])
    case error(Error)
    case loading
}
