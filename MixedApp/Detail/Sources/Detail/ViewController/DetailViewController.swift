//
//  DetailViewController.swift
//
//
//  Created by bastian.veliz.vega on 05-02-22.
//

import Coordinator
import Core
import Foundation
import ReSwift
import UIComponents
import UIKit

final class DetailViewController: UIViewController {
    private let favoritesProvider: FavoritesProviderProtocol
    private let movie: MovieModel
    private let genresProvider: GenresProviderProtocol

    lazy var store: Store<DetailViewStateNew> = {
        let mainReducer = MainReducer()
        let store = Store(reducer: mainReducer.mainReducer(_:_:),
                          state: DetailViewStateNew(),
                          middleware: [
                              LoadGenresMiddleware().middleware,
                          ])
        mainReducer.store = store
        return store
    }()

    private lazy var viewModel: DetailViewModelStore = {
        let viewModel = DetailViewModelStore(movie: self.movie,
                                             genresProvider: self.genresProvider,
                                             favoritesProvider: self.favoritesProvider,
                                             store: self.store)
        return viewModel
    }()

    private lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                   style: .plain, target: self,
                                   action: #selector(favoriteButtonTapped))
        return item
    }()

    private let coordinator: CoordinatorProtocol?

    init(movie: MovieModel,
         genresProvider: GenresProviderProtocol,
         favoritesProvider: FavoritesProviderProtocol,
         coordinator: CoordinatorProtocol?)
    {
        self.movie = movie
        self.genresProvider = genresProvider
        self.favoritesProvider = favoritesProvider
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    convenience init(movie: MovieModel,
                     favoritesProvider: FavoritesProviderProtocol,
                     coordinator: CoordinatorProtocol)
    {
        let cacheService = NSKeyedArchiverCache()
        let apiService = MovieDBCloudService()
        let genresProvider = GenresProvider(apiService: apiService, cacheService: cacheService)

        self.init(movie: movie,
                  genresProvider: genresProvider,
                  favoritesProvider: favoritesProvider,
                  coordinator: coordinator)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.navigationItem.title = self.movie.title
        self.navigationItem.rightBarButtonItem = self.favoriteBarButtonItem
    }

    override func loadView() {
        let view = UIView()
        self.view = view
        let detailViewNew = DetailViewNew(viewModel: self.viewModel)
        self.addSubSwiftUIView(detailViewNew, to: view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.store.unsubscribe(self)
    }
}

private extension DetailViewController {
    @objc
    func favoriteButtonTapped() {
        let favoriteState = self.viewModel.viewState.favoriteState.state

        switch favoriteState {
        case .movieIsNotFavorite:
            let action = FavoriteMovieActions.SetFavoriteStatus(movie: self.movie,
                                                                willBeFavorite: true,
                                                                favoritesProvider: self.favoritesProvider,
                                                                store: self.store)
            self.store.dispatch(action)
        case .movieIsFavorite:
            let action = FavoriteMovieActions.SetFavoriteStatus(movie: self.movie,
                                                                willBeFavorite: false,
                                                                favoritesProvider: self.favoritesProvider,
                                                                store: self.store)
            self.store.dispatch(action)
        default:
            break
        }
    }
}

extension DetailViewController {
    func mainReducer(_ action: Action, _ state: DetailViewStateNew?) -> DetailViewStateNew {
        let reducer = DetailViewReducer(store: self.store).detailViewReducer(action, state)
        let favoriteState = FavoriteReducer().favoriteReducer(action, state?.favoriteState)
        return DetailViewStateNew(state: reducer.state,
                                  favoriteState: favoriteState)
    }
}

extension DetailViewController: StoreSubscriber {
    func newState(state: DetailViewStateNew) {
        let favoriteState = state.favoriteState.state

        switch favoriteState {
        case .movieIsNotFavorite:
            self.favoriteBarButtonItem.image = UIImage(systemName: "heart")
        case .movieIsFavorite:
            self.favoriteBarButtonItem.image = UIImage(systemName: "heart.fill")
        case let .withError(_, movieWasFavorite):
            self.showErrorAlert(movieWasFavorite: movieWasFavorite)
            let action = FavoriteMovieActions.UpdateFavoriteStatus(isFavorite: movieWasFavorite)
            self.store.dispatch(action)
        }
    }
}

extension DetailViewController {
    func showErrorAlert(movieWasFavorite: Bool) {
        let word = movieWasFavorite ? L10n.removing : L10n.adding
        let message = L10n.errorYourMovieAsFavorite(word)
        self.coordinator?.handle(event: DetailViewCoordinatorEvent.showErrorAlert(message: message))
    }
}
