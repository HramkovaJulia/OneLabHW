//
//  ViewController.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    private let viewModel: SettingsViewModelProtocol?
    
    private lazy var settingsView =  SettingsView(delegate: self)
    
    private lazy var data: [Section] = viewModel!.data
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navBarSetting()
        settingsView.configureTableView(dataSource: self, delegate: self)
    }
    
    override func loadView() {
        super.loadView()
        view = settingsView
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

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].settings.count
        
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
        
        let setting = data[indexPath.section].settings[indexPath.row]
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
        let setting = data[section].settings[row]
        
        if setting.title == "Bluetooth" {
//            viewModel!.updateState(viewInput: .bluetoothDidSelect)
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
//            navigationController!.pushViewController(viewControllerToPush, animated: true)
            viewModel?.updateState(viewInput: .bluetoothDidSelect)
        }
    }
}

extension SettingsViewController: UIScrollViewDelegate {
    
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


extension SettingsViewController: SettingsViewDelegate {
    func bluetoothDidTap() {
//        viewModel!.updateState(viewInput: .bluetoothDidSelect)
        print("TAAPPP")
    }
}
