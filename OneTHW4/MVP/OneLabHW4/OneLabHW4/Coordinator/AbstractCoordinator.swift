//
//  AbstractCoordinator.swift
//  OneLabHW4
//
//  Created by Julia on 14.04.2023.
//

import Foundation

protocol AbstractCoordinator {
    func addChildCoordinator(_ coordinator: AbstractCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}
