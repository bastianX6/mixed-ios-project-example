//
//  FavoriteListCoordinator.swift
//
//
//  Created by bastian.veliz.vega on 05-02-22.
//

import Coordinator
import Core
import Foundation
import UIKit

public final class FavoriteListCoordinator: BaseCoordinator {
    weak var parentViewController: UINavigationController?
    private let favoritesProvider: FavoritesProviderProtocol

    public init(parentCoordinator: CoordinatorProtocol?,
                parentViewController: UINavigationController?,
                favoritesProvider: FavoritesProviderProtocol)
    {
        self.parentViewController = parentViewController
        self.favoritesProvider = favoritesProvider
        super.init(parentCoordinator: parentCoordinator)
    }

    override public func start(_ completion: @escaping () -> Void) {
        let viewController = FavoriteListViewController(favoritesProvider: favoritesProvider,
                                                        coordinator: self)
        let tabBarItem = UITabBarItem(title: "Favorites",
                                      image: UIImage(systemName: "heart.fill"),
                                      selectedImage: UIImage(systemName: "heart.fill"))
        viewController.tabBarItem = tabBarItem
        parentViewController?.setViewControllers([viewController], animated: true)
        completion()
    }

    override public func handle(event: CoordinatorEvent) {
        if let favoriteEvent = event as? FavoriteListCoordinatorEvent {
            handle(favoriteEvent)
        }
    }
}

private extension FavoriteListCoordinator {
    func handle(_ event: FavoriteListCoordinatorEvent) {
        switch event {
        case let .goToDetail(movie):
            parentCoordinator?.handle(event: FavoriteListExternalCoordinatorEvent.goToDetail(movie: movie))
        }
    }
}
