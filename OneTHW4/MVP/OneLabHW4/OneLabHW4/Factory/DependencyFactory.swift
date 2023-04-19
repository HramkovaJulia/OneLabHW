//
//  DependencyFactory.swift
//  OneLabHW4
//
//  Created by Julia on 14.04.2023.
//

import Foundation

protocol Factory {
    func makeSettingsViewController(coordinator: ProjectCoordinator) -> SettingsViewController
    func makeBluetoothViewController(coordinator: ProjectCoordinator, data: [Section]) -> BluetoothViewController
}

class DependencyFactory: Factory {
   
    func makeSettingsViewController(coordinator: ProjectCoordinator) -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(coordinator: coordinator, view: viewController)
        viewController.set(presenter: presenter)
        return viewController
    }
    
    func makeBluetoothViewController(coordinator: ProjectCoordinator, data: [Section]) -> BluetoothViewController {
        let viewController = BluetoothViewController(data: data)
        let presenter = BluetoothPresenter(view: viewController)
        viewController.set(presenter: presenter)
        return viewController
    }
    
    struct Dependencies {
            // this can be used for Network Managers, and similar
        }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeInitialCoordinator() -> ProjectCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
}
