//
//  Module.swift
//  OneLabHW4
//
//  Created by Julia on 17.04.2023.
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    enum ModuleType {
        case settings
        case bluetooth
    }

    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
}
