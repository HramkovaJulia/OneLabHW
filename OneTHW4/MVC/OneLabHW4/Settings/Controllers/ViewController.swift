//
//  ViewController.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var settings: Settings = Settings(sections: [])

    let section1 = Section(title: "General", settings: [
        Setting(title: "Airplane mode", imageName: "air", color: .systemRed),
        Setting(title: "Wi-Fi", imageName: "wifi", color: .systemBlue),
        Setting(title: "Bluetooth", imageName: "bluetooth", color: .systemGreen),
        Setting(title: "Mobile Data", imageName: "data", color: .systemOrange),
        Setting(title: "Personal Hotspot", imageName: "link", color: .systemPurple),
        Setting(title: "VPN", imageName: "vpn", color: .systemRed)
    ])

    let section2 = Section(title: "Appearance", settings: [
        Setting(title: "Notification", imageName: "bell", color: .systemRed),
        Setting(title: "Sounds", imageName: "volume", color: .systemBlue),
        Setting(title: "Focus", imageName: "moon", color: .systemGreen)
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetting()
        settings = Settings(sections: [section1, section2])
    }
    
    override func loadView() {
        let myView = View()
        view = myView
        myView.tableView.dataSource = self
        myView.tableView.delegate = self
        myView.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    func navBarSetting() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26.0) // Устанавливаем жирный шрифт
        titleLabel.textColor = .white // Устанавливаем белый цвет текста
        titleLabel.text = "Settings" // Устанавливаем текст заголовка
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
        
        let searchController = UISearchController(searchResultsController: nil)
        let textField = searchController.searchBar.value(forKey: "searchField") as! UISearchTextField
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray // set the placeholder text color to white
            ]
            textFieldInsideSearchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
        }
        if let searchTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let searchIcon = searchTextField.leftView as? UIImageView {
                searchIcon.image = searchIcon.image?.withRenderingMode(.alwaysTemplate)
                searchIcon.tintColor = UIColor.lightGray
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.sections[section].settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let button = UIButton()
        button.setTitle("Off", for: .normal)
        button.setImage(UIImage(named: "next"), for: .normal)
        button.sizeToFit() // установка размеров кнопки в соответствии с ее содержимым
        button.contentHorizontalAlignment = .right // выравнивание содержимого кнопки по правому краю

        if indexPath.section == 0 || indexPath.section == 1 {
              if indexPath.row == 0 {
                  let switchView = UISwitch(frame: .zero)
                  switchView.isOn = true // Set the initial state of the switch
//                  switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
                  cell.accessoryView = switchView
              }
          }
        
        if indexPath.row == 2 {
            button.setTitle("", for: .normal)
            cell.accessoryView = button
        }
        if indexPath.row == 3 || indexPath.row == 4{
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.tintColor = .gray
            button.semanticContentAttribute = .forceRightToLeft
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
            button.frame = CGRect(x: 0, y: 0, width: 100, height: 40) // установка размеров кнопки
            cell.accessoryView = button
        }

        let setting = settings.sections[indexPath.section].settings[indexPath.row]
        cell.setupData(lbl: setting.title, image: setting.imageName, back: setting.color)

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
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

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let threshold: CGFloat = 50 // порог для изменения цвета

        if offsetY > threshold {
            navigationController?.navigationBar.backgroundColor = .clear
        } else {
            navigationController?.navigationBar.backgroundColor = .clear
        }
    }
}
