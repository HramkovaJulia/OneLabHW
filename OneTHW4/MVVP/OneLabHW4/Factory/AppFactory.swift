//
//  DependencyFactory.swift
//  OneLabHW4
//
//  Created by Julia on 14.04.2023.
//

import UIKit

final class AppFactory {
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        let viewModel = SettingsViewModel()
        let view = UINavigationController(rootViewController: SettingsViewController(viewModel: viewModel))
        return Module(moduleType: moduleType, viewModel: viewModel, view: view)
    }
}
