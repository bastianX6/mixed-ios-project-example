//
//  ListViewModel.swift
//
//
//  Created by bastian.veliz.vega on 19-04-21.
//

import Combine
import Core
import Foundation

protocol ListViewDelegate: AnyObject {
    func didTapCell(movie: MovieModel)
}

class ListViewModel: ObservableObject {
    @Published private(set) var viewState: ListViewState = .loading
    @Published var listItems: [ListCellGridModel] = []

    private var favoriteMovies: [MovieModel] = []
    private var currentPage: Int?
    private var totalPages: Int = 0

    private var cancellableArray: [AnyCancellable] = []
    private let provider: ListDataProviderProtocol
    private let favoritesProvider: FavoritesProviderProtocol
    weak var delegate: ListViewDelegate?

    init(provider: ListDataProviderProtocol,
         favoritesProvider: FavoritesProviderProtocol)
    {
        self.provider = provider
        self.favoritesProvider = favoritesProvider
    }

    func loadFirstItems() {
        if self.listItems.isEmpty {
            self.loadMovies()
        } else {
            self.loadFavoriteMovies()
        }
    }

    func loadNewItemsIfNeeded(model: MovieModel) {
        guard let lastModel = self.listItems.last, lastModel.model.id == model.id else { return }
        self.loadMovies()
    }

    private func loadMoviesOld() {
        self.cancellableArray.forEach {
            $0.cancel()
        }

        self.cancellableArray.removeAll()

        let future = Future<[MovieModel], Error> { [weak self] promise in
            guard let self = self else { return }
            do {
                let favoriteMovies = try self.favoritesProvider.getAllFavorites()
                promise(.success(favoriteMovies))
            } catch {
                promise(.failure(error))
            }
        }

        var page: Int?

        if let currentPage = self.currentPage {
            page = currentPage + 1
        }

        self.provider
            .getMovieList(page: page, language: nil)
            .zip(future)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case let .failure(error):
                    debugPrint("error: \(error)")
                    self.viewState = .error(error)
                default:
                    break
                }
            } receiveValue: { [weak self] list, favoriteMovies in
                guard let self = self else { return }
                self.currentPage = list.currentPage
                self.totalPages = list.totalPages
                self.favoriteMovies = favoriteMovies
                self.updateView(models: list.movies)
            }
            .store(in: &self.cancellableArray)
    }

    private func loadMovies() {
        self.cancellableArray.forEach {
            $0.cancel()
        }

        self.cancellableArray.removeAll()

        var page: Int?

        if let currentPage = self.currentPage {
            page = currentPage + 1
        }

        self.provider
            .getMovieList(page: page, language: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case let .failure(error):
                    debugPrint("error: \(error)")
                    self.viewState = .error(error)
                default:
                    break
                }
            } receiveValue: { [weak self] list in
                guard let self = self else { return }
                self.currentPage = list.currentPage
                self.totalPages = list.totalPages
                self.updateView(models: list.movies)
                self.loadFavoriteMovies()
            }
            .store(in: &self.cancellableArray)
    }

    func loadFavoriteMovies() {
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
                case let .failure(error):
                    debugPrint("error: \(error)")
                    self.viewState = .error(error)
                default:
                    break
                }
            } receiveValue: { [weak self] favoriteMovies in
                guard let self = self else { return }
                self.favoriteMovies = favoriteMovies
                self.updateFavoriteMovies()
            }
            .store(in: &self.cancellableArray)
    }

    // MARK: - Update view

    private func updateView(models: [MovieModel]) {
        let data = models.map { movie -> ListCellGridModel in
            let isFavorite = favoriteMovies.contains(where: { $0.id == movie.id })
            return ListCellGridModel(model: movie, isFavorite: isFavorite)
        }
        self.listItems.append(contentsOf: data)

        switch self.viewState {
        case .error, .loading:
            self.viewState = .withData
        default:
            break
        }
    }

    private func updateFavoriteMovies() {
        guard !self.listItems.isEmpty else { return }

        for index in 0 ..< self.listItems.count {
            let item = self.listItems[index]
            let isFavorite = self.favoriteMovies.contains(where: { $0.id == item.model.id })
            self.listItems[index].isFavorite = isFavorite
        }
    }

    // MARK: - Handle navigation

    func didTapCell(movie: MovieModel) {
        self.delegate?.didTapCell(movie: movie)
    }
}

enum ListViewState {
    case withData
    case error(Error)
    case loading
}
