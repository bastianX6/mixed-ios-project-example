//
//  FavoriteListViewController.swift
//
//
//  Created by bastian.veliz.vega on 05-02-22.
//

import Coordinator
import Core
import Foundation
import UIComponents
import UIKit

final class FavoriteListViewController: UIViewController {
    private let favoritesProvider: FavoritesProviderProtocol
    private lazy var viewModel: FavoritesListViewModel = {
        let viewModel = FavoritesListViewModel(favoritesProvider: self.favoritesProvider)
        viewModel.delegate = self
        return viewModel
    }()

    private let coordinator: CoordinatorProtocol?

    init(favoritesProvider: FavoritesProviderProtocol,
         coordinator: CoordinatorProtocol?)
    {
        self.favoritesProvider = favoritesProvider
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.navigationItem.title = L10n.favoriteMovies
    }

    override func loadView() {
        let view = UIView()
        self.view = view
        let favoritesListView = FavoritesListView(viewModel: self.viewModel)
        self.addSubSwiftUIView(favoritesListView, to: view)
    }
}

extension FavoriteListViewController: FavoritesListViewDelegate {
    func didTapCell(movie: MovieModel) {
        self.coordinator?.handle(event: FavoriteListCoordinatorEvent.goToDetail(movie: movie))
    }
}
