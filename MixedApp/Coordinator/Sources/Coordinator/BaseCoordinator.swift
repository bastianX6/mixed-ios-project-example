//
//  BaseCoordinator.swift
//
//
//  Created by bastian.veliz.vega on 10-02-22.
//

import Foundation

open class BaseCoordinator: CoordinatorProtocol {
    public let parentCoordinator: CoordinatorProtocol?

    public init(parentCoordinator: CoordinatorProtocol? = nil) {
        self.parentCoordinator = parentCoordinator
    }

    open func handle(event: CoordinatorEvent) {}

    open func start(_ completion: @escaping () -> Void) {
        completion()
    }
}
