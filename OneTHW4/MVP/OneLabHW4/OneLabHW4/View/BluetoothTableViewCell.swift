//
//  BluetoothTableViewCell.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 09.04.2023.
//

import UIKit

class BluetoothTableViewCell: UITableViewCell {

    static var identifier = "BluetoothTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183908954, alpha: 1)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(label)
        horizontalStackView.addArrangedSubview(button)
        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .infoLight)
        button.setTitle("Not connected", for: .normal)
        button.sizeToFit()
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .gray
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    func setupData(lbl: String, image: String?, back: UIColor?) {
        label.text = lbl
    }
}
