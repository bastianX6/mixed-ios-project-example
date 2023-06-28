//
//  ListViewController.swift
//
//
//  Created by bastian.veliz.vega on 04-02-22.
//

import Coordinator
import Core
import Foundation
import UIComponents
import UIKit

final class ListViewController: UIViewController {
    private let listDataProvider: ListDataProviderProtocol
    private let favoritesProvider: FavoritesProviderProtocol
    private lazy var viewModel: ListViewModel = {
        let viewModel = ListViewModel(provider: self.listDataProvider,
                                      favoritesProvider: self.favoritesProvider)
        viewModel.delegate = self
        return viewModel
    }()

    private let coordinator: CoordinatorProtocol?

    init(listDataProvider: ListDataProviderProtocol,
         favoritesProvider: FavoritesProviderProtocol,
         coordinator: CoordinatorProtocol?)
    {
        self.listDataProvider = listDataProvider
        self.favoritesProvider = favoritesProvider
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    convenience init(favoritesProvider: FavoritesProviderProtocol,
                     coordinator: CoordinatorProtocol)
    {
        let service = MovieDBCloudService()
        let listDataProvider = ListDataProvider(service: service)
        self.init(listDataProvider: listDataProvider,
                  favoritesProvider: favoritesProvider,
                  coordinator: coordinator)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.navigationItem.title = L10n.popularMovies
    }

    override func loadView() {
        let view = UIView()
        self.view = view
        let listView = ListView(viewModel: self.viewModel)
        self.addSubSwiftUIView(listView, to: view)
    }
}

extension ListViewController: ListViewDelegate {
    func didTapCell(movie: MovieModel) {
        self.coordinator?.handle(event: ListCoordinatorEvent.goToDetail(movie: movie))
    }
}
