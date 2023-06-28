//
//  DetailViewCoordinator.swift
//
//
//  Created by bastian.veliz.vega on 05-02-22.
//

import Coordinator
import Core
import Foundation
import UIKit

public final class DetailViewCoordinator: BaseCoordinator {
    weak var parentViewController: UINavigationController?
    private let movie: MovieModel
    private let favoritesProvider: FavoritesProviderProtocol

    public init(parentCoordinator: CoordinatorProtocol?,
                parentViewController: UINavigationController?,
                movie: MovieModel,
                favoritesProvider: FavoritesProviderProtocol)
    {
        self.parentViewController = parentViewController
        self.movie = movie
        self.favoritesProvider = favoritesProvider
        super.init(parentCoordinator: parentCoordinator)
    }

    override public func start(_ completion: @escaping () -> Void) {
        let viewController = DetailViewController(movie: movie,
                                                  favoritesProvider: favoritesProvider,
                                                  coordinator: self)
        parentViewController?.pushViewController(viewController, animated: true)
        completion()
    }

    override public func handle(event: CoordinatorEvent) {
        if let detailEvent = event as? DetailViewCoordinatorEvent {
            handle(detailEvent)
        }
    }
}

extension DetailViewCoordinator {
    func handle(_ event: DetailViewCoordinatorEvent) {
        switch event {
        case let .showErrorAlert(message):
            let alertTitle = L10n.error
            let alertMessage = message
            let okButtonText = L10n.accept

            let button = UIAlertAction(title: okButtonText, style: .default)
            let alert = UIAlertController(title: alertTitle,
                                          message: alertMessage,
                                          preferredStyle: .alert)
            alert.addAction(button)
            parentViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
