import XCTest

@testable import Coordinator

enum Event: CoordinatorEvent {
    case event
}

final class Coordinator: BaseCoordinator {
    var events: [CoordinatorEvent] = []

    override func handle(event: CoordinatorEvent) {
        events.append(event)
    }
}

final class CoordinatorTests: XCTestCase {
    func testHandlerOfCoordinator() {
        let coordinator = Coordinator()

        XCTAssertEqual(coordinator.events.count, 0)
        coordinator.handle(event: Event.event)
        XCTAssertEqual(coordinator.events.count, 1)
    }
}
