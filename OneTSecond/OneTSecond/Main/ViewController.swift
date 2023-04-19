//
//  ViewController.swift
//  OneTSecond
//
//  Created by Artyom Prima on 31.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = " Second Homework "
        setSubview()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()

    private func setSubview() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.layer.cornerRadius = 12
        cell.layer.borderColor = #colorLiteral(red: 0.58187747, green: 0.6370299459, blue: 0.7215286493, alpha: 1)
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        switch indexPath.section {
        case 0:
            cell.scrollName(text: "ScrollView")
            return cell
        case 1:
            cell.scrollName(text: "Pinterest")
            return cell
        case 2:
            cell.scrollName(text: "Contacts")
            return cell
        default:
            return TableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let vc = ScrollViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Add Account"
        case 1:
            let vc = PinterestViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Feed"
        case 2:
            let vc = ContactsViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Contacts"
        default:
            print("error")
        }
    }
}
