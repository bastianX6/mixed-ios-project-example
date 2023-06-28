//
//  ListCoordinator.swift
//
//
//  Created by bastian.veliz.vega on 04-02-22.
//

import Coordinator
import Core
import Foundation
import UIKit

public final class ListCoordinator: BaseCoordinator {
    private weak var parentViewController: UINavigationController?
    private let favoritesProvider: FavoritesProviderProtocol

    public init(
        parentCoordinator: CoordinatorProtocol?,
        parentViewController: UINavigationController,
        favoritesProvider: FavoritesProviderProtocol
    ) {
        self.parentViewController = parentViewController
        self.favoritesProvider = favoritesProvider
        super.init(parentCoordinator: parentCoordinator)
    }

    override public func start(_ completion: @escaping () -> Void) {
        let viewController = ListViewController(favoritesProvider: favoritesProvider,
                                                coordinator: self)

        let tabBarItem = UITabBarItem(title: "Movies",
                                      image: UIImage(systemName: "list.and.film"),
                                      selectedImage: UIImage(systemName: "list.and.film"))
        viewController.tabBarItem = tabBarItem

        parentViewController?.setViewControllers([viewController], animated: true)
        completion()
    }

    override public func handle(event: CoordinatorEvent) {
        if let listEvent = event as? ListCoordinatorEvent {
            handle(listEvent)
        }
    }
}

private extension ListCoordinator {
    func handle(_ event: ListCoordinatorEvent) {
        switch event {
        case let .goToDetail(movie):
            parentCoordinator?.handle(event: ListExternalCoordinatorEvent.goToDetail(movie: movie))
        }
    }
}
