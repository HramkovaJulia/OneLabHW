//
//  AbstractCoordinator.swift
//  OneLabHW4
//
//  Created by Julia on 14.04.2023.
//

import UIKit

final class AppCoordinator: Coordinatable {
    private(set) var childCoordinators: [Coordinatable] = []

    private let factory: AppFactory

    init(factory: AppFactory) {
        self.factory = factory
    }

    func start() -> UIViewController {
        let settingsCoordinator = SettingsCoordinator(moduleType: .settings, factory: factory)
        let vc = settingsCoordinator.start()
        addChildCoordinator(settingsCoordinator)
        return vc
    }

    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 === coordinator }
    }
}
