//
//  BluetoothViewController.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import UIKit

class BluetoothViewController: UIViewController {

    var settings: Settings = Settings(sections: [])

    let section1 = Section(title: "MY DEVICES", settings: [
        Setting(title: "BeatsByDre", imageName: "", color: .clear),
        Setting(title: "13$1BT", imageName: "", color: .clear),
        Setting(title: "Nai`s AirPods Pro", imageName: "", color: .clear),
        Setting(title: "Nora`s AirPods Pro 2", imageName: "", color: .clear),
        Setting(title: "Y7", imageName: "", color: .clear),
        Setting(title: "SHAKE-X3D", imageName: "", color: .clear)
    ])

    let section2 = Section(title: "OTHER DEVICES", settings: [
        Setting(title: "EnOL", imageName: "", color: .clear),
        Setting(title: "somebody`s son", imageName: "", color: .clear)
    ])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = Settings(sections: [section1, section2])
        view.backgroundColor = .black
        self.title = "Bluetooth"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func loadView() {
        let myView = View()
        view = myView
        myView.tableView.dataSource = self
        myView.tableView.delegate = self
        myView.tableView.register(BluetoothTableViewCell.self, forCellReuseIdentifier: BluetoothTableViewCell.identifier)
    }
}


extension BluetoothViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.sections[section].settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BluetoothTableViewCell.identifier, for: indexPath) as? BluetoothTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let setting = settings.sections[indexPath.section].settings[indexPath.row]
        cell.setupData(lbl: setting.title, image: setting.imageName, back: setting.color)
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return section1.title
        case 1:
            return section2.title
        default:
            return "error"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.size.width - 32, height: 30))
        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .gray
        titleLabel.backgroundColor = .black
        headerView.addSubview(titleLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // Add 10-point spacing between sections
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.cornerRadius = 0
            cell.layer.maskedCorners = []
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        let setting = settings.sections[section].settings[row]

        // Проверяем, что выбрана ячейка с Bluetooth
        if setting.title == "Bluetooth" {
            // Создаем экземпляр контроллера и отображаем его
            let bluetoothVC = BluetoothViewController()
            self.navigationController?.pushViewController(bluetoothVC, animated: true)
        }
    }
}
