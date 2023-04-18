//
//  SettingsView.swift
//  OneLabHW4
//
//  Created by Julia on 17.04.2023.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func bluetoothDidTap()
}

final class SettingsView: UIView {
    
    var tapAction: (() -> Void)?
    
    private weak var delegate: SettingsViewDelegate?
    
    private let tableView = UITableView()
    
    init(delegate: SettingsViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }
    
    func configureTableView(dataSource: UITableViewDataSource,
                                 delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    @objc private func bluetoothDidTap() {
//        delegate?.bluetoothDidTap()
//        tapAction?()
    }
}
