//
//  BluetoothViewController.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import UIKit

class BluetoothViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var data: [Section] = []
    
    var bluetoothPresenter: BluetoothPresenter?
    
    init(data: [Section]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.title = "Bluetooth"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view).inset(UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BluetoothTableViewCell.self, forCellReuseIdentifier: BluetoothTableViewCell.identifier)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
}


extension BluetoothViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BluetoothTableViewCell.identifier, for: indexPath) as? BluetoothTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let setting = data[indexPath.section].settings[indexPath.row]
        cell.setupData(lbl: setting.title, image: setting.imageName, back: setting.color)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return data[0].title
        case 1:
            return data[1].title
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
        return 35 // Add 10-point spacing between sections
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
}

extension BluetoothViewController {
    func set(presenter: BluetoothPresenter) {
        self.bluetoothPresenter = presenter
    }
}
