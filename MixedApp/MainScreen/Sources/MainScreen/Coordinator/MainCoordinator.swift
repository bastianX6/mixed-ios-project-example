//
//  MainCoordinator.swift
//
//
//  Created by bastian.veliz.vega on 04-02-22.
//

import Coordinator
import Core
import Detail
import FavoriteList
import Foundation
import List
import UIKit

public class MainCoordinator: BaseCoordinator {
    weak var window: UIWindow?
    weak var tabBarViewController: MainTabBarViewController?

    public init(window: UIWindow?) {
        self.window = window
        super.init()
    }

    override public func start(_ completion: @escaping () -> Void) {
        let listNavigationController = UINavigationController(nibName: nil, bundle: nil)
        let favoritesNavigationController = UINavigationController(nibName: nil, bundle: nil)

        let tabBarController = MainTabBarViewController(viewControllers:
            [
                listNavigationController,
                favoritesNavigationController,
            ]
        )

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        startListCoordinator(navigationController: listNavigationController)
        startFavoritesCoordinator(navigationController: favoritesNavigationController)
        tabBarViewController = tabBarController
        completion()
    }

    override public func handle(event: CoordinatorEvent) {
        if let listEvent = event as? ListExternalCoordinatorEvent {
            handle(listEvent)
        }

        if let favoriteListEvent = event as? FavoriteListExternalCoordinatorEvent {
            handle(favoriteListEvent)
        }
    }
}

private extension MainCoordinator {
    func startListCoordinator(navigationController: UINavigationController) {
        let cacheService = NSKeyedArchiverCache()
        let favoriteService = FavoritesService(cacheService: cacheService)
        let favoritesProvider = FavoritesProvider(service: favoriteService)

        let coordinator = ListCoordinator(parentCoordinator: self,
                                          parentViewController: navigationController,
                                          favoritesProvider: favoritesProvider)
        coordinator.start {}
    }

    func startFavoritesCoordinator(navigationController: UINavigationController) {
        let cacheService = NSKeyedArchiverCache()
        let favoriteService = FavoritesService(cacheService: cacheService)
        let favoritesProvider = FavoritesProvider(service: favoriteService)

        let coordinator = FavoriteListCoordinator(parentCoordinator: self,
                                                  parentViewController: navigationController,
                                                  favoritesProvider: favoritesProvider)
        coordinator.start {}
    }

    func startDetailsCoordinator(navigationController: UINavigationController,
                                 movie: MovieModel)
    {
        let cacheService = NSKeyedArchiverCache()
        let favoriteService = FavoritesService(cacheService: cacheService)
        let favoritesProvider = FavoritesProvider(service: favoriteService)

        let coordinator = DetailViewCoordinator(parentCoordinator: self,
                                                parentViewController: navigationController,
                                                movie: movie,
                                                favoritesProvider: favoritesProvider)
        coordinator.start {}
    }
}

private extension MainCoordinator {
    func handle(_ event: ListExternalCoordinatorEvent) {
        switch event {
        case let .goToDetail(movie):
            guard let navigationController = tabBarViewController?.viewControllers?.first as? UINavigationController else { return }
            startDetailsCoordinator(navigationController: navigationController,
                                    movie: movie)
        }
    }

    func handle(_ event: FavoriteListExternalCoordinatorEvent) {
        switch event {
        case let .goToDetail(movie):
            guard let navigationController = tabBarViewController?.viewControllers?.last as? UINavigationController else { return }
            startDetailsCoordinator(navigationController: navigationController,
                                    movie: movie)
        }
    }
}
