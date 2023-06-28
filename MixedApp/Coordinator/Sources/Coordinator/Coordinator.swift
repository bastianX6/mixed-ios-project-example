//
//  Coordinator.swift
//  
//
//  Created by bastian.veliz.vega on 10-02-22.
//

import Foundation

public protocol CoordinatorProtocol: AnyObject {
    var parentCoordinator: CoordinatorProtocol? { get }

    func handle(event: CoordinatorEvent)
    func start(_ completion: @escaping () -> Void)
}

public extension CoordinatorProtocol {
    var parentCoordinator: CoordinatorProtocol? { return nil }
}
