

import Foundation

protocol BluetoothPresenterProtocol {
    var data: [Section] { get set }
    func showDetail(data: [Section])
}

class BluetoothPresenter {
   
    weak var view: BluetoothViewController?

    private var coordinator: ProjectCoordinator?
    
    init(view: BluetoothViewController) {
        self.view = view
    }
}

extension BluetoothPresenter: BluetoothPresenterProtocol  {
    func showDetail(data: [Section]) {
        coordinator?.moveToDetail(withData: data)
    }
    
    var data: [Section] {
        get {
            [
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
            ]
        }
        set {
            
        }
    }
}
