//
//  ViewController.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    var settingsPresenter: SettingsPresenterProtocol?
    
    private let tableView = UITableView()
    
    private var data: [Section] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetting()
        
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    override func loadView() {
            let view = UIView()
            view.backgroundColor = .red
            self.view = view
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
        return settingsPresenter!.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsPresenter!.data[section].settings.count
        
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
        
        let setting = settingsPresenter!.data[indexPath.section].settings[indexPath.row]
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
        let setting = settingsPresenter!.data[section].settings[row]
        
        if setting.title == "Bluetooth" {
            settingsPresenter?.buttonPressed()
            
            settingsPresenter?.showDetail(data: [
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
            )
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

extension SettingsViewController {
    func set(presenter: SettingsPresenterProtocol) {
        self.settingsPresenter = presenter
    }
}
