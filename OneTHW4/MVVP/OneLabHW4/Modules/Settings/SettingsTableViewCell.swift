//
//  TableViewCell.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static var identifier = "TableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183908954, alpha: 1)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(26)
        }
        horizontalStackView.addArrangedSubview(label)
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
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    func setupData(lbl: String, image: String?, back: UIColor?) {
        label.text = lbl
        if let image = image, let back = back {
            iconImageView.image = UIImage(named: image)
            iconImageView.backgroundColor = back
        }
    }
}
