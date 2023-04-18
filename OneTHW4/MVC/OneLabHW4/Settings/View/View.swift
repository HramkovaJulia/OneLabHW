//
//  View.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import UIKit

class View: UIView {
    
   let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
