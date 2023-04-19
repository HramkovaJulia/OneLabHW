//
//  RootCoordinator.swift
//  OneLabHW4
//
//  Created by Julia on 14.04.2023.
//

import UIKit

final class SettingsCoordinator: ModuleCoordinatable {
  
    private let factory: AppFactory

    var moduleType: Module.ModuleType
    
    private(set) var module: Module?
    private(set) var childCoordinators: [Coordinatable] = []
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        (module.viewModel as? SettingsViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushBookViewController() {
        let viewControllerToPush = BluetoothViewController(data: [
            Section(title: "MY DEVICES", settings: [
                Setting(title: "BeatsByDre", imageName: "", color: .clear),
                Setting(title: "13$1BT", imageName: "", color: .clear),
                Setting(title: "Nai`s AirPods Pro", imageName: "", color: .clear),
                Setting(title: "Nora`s AirPods Pro 2", imageName: "", color: .clear),
                Setting(title: "Y7", imageName: "", color: .clear),
                Setting(title: "SHAKE-X3D", imageName: "", color: .clear)
            ]),
            Section(title: "OTHER DEVICES", settings: [
                Setting(title: "EnOL", imageName: "", color: .clear),
                Setting(title: "somebody`s son", imageName: "", color: .clear)
            ])
        ])
        (module?.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)    }
}
