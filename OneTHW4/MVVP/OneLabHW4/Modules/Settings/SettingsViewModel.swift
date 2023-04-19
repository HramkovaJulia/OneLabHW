//
//  SettingsViewModelProtocol.swift
//  OneLabHW4
//
//  Created by Julia on 17.04.2023.
//

import Foundation

protocol SettingsViewModelProtocol: ViewModelProtocol {
    var data: [Section] { get set }
    func updateState(viewInput: SettingsViewModel.ViewInput)
}

final class SettingsViewModel: SettingsViewModelProtocol {
  
    weak var coordinator: SettingsCoordinator?
    
    var onStateDidChange: (() -> Void)?
    
    enum ViewInput {
        case bluetoothDidSelect
    }
    
    var data: [Section] {
        get {
            [
                Section(title: "General", settings: [
                    Setting(title: "Airplane mode", imageName: "air", color: .systemRed),
                    Setting(title: "Wi-Fi", imageName: "wifi", color: .systemBlue),
                    Setting(title: "Bluetooth", imageName: "bluetooth", color: .systemGreen),
                    Setting(title: "Mobile Data", imageName: "data", color: .systemOrange),
                    Setting(title: "Personal Hotspot", imageName: "link", color: .systemPurple),
                    Setting(title: "VPN", imageName: "vpn", color: .systemRed)
                ]),
                Section(title: "Appearance", settings: [
                    Setting(title: "Notification", imageName: "bell", color: .systemRed),
                    Setting(title: "Sounds", imageName: "volume", color: .systemBlue),
                    Setting(title: "Focus", imageName: "moon", color: .systemGreen)
                ])
            ]
        }
        set {
            
        }
    }
    
    func updateState(viewInput: ViewInput) {
        coordinator?.pushBookViewController()
    }
}
