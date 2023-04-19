//
//  ScrollViewCell.swift
//  OneTSecond
//
//  Created by Artyom Prima on 01.04.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = "ScrollViewCell"
    
    var didScrollTapped: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(26)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    func scrollName(text: String) {
        name.text = text
    }
}
