//
//  ProjeactCoordinator.swift
//  OneLabHW4
//
//  Created by Julia on 14.04.2023.
//

import UIKit

class ProjectCoordinator: AbstractCoordinator, RootCoordinator {
 
    private(set) var childCoordinators: [AbstractCoordinator] = []
    
    weak var navigationController: UINavigationController?
    private var factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
    }
    
    func addChildCoordinator(_ coordinator: AbstractCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    /// Start the coordinator, intiializing dependencies
    /// - Parameter navigationController: The host UINavigationController
    func start(_ navigationController: UINavigationController) {
        let vc = factory.makeSettingsViewController(coordinator: self)
        self.navigationController = navigationController
        navigationController.pushViewController(vc, animated: true)
    }
    
    func moveToDetail(withData data: [Section]) {
        let vc = factory.makeBluetoothViewController(coordinator: self, data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}
