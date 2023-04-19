//
//  TableViewCell.swift
//  ThirdOneTHW
//
//  Created by Artyom Prima on 04.04.2023.
//
import UIKit

class TableViewCell: UITableViewCell {

    var completionTadded: ((UIButton) -> Void)?
    
    static var identifier = "TableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.addArrangedSubview(checkboxButton)
        stackView.addArrangedSubview(label)
        contentView.addSubview(stackView)
       
        stackView.snp.makeConstraints { make in
            make.top.leading. trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(64).priority(.required)
            make.height.lessThanOrEqualTo(100).priority(.required)
        }
        checkboxButton.layer.cornerRadius = checkboxButton.bounds.width / 2
        checkboxButton.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0 // Многстрочный лейбл
        label.adjustsFontSizeToFitWidth = true // Уменьшать размер шрифта, чтобы весь текст поместился
        label.minimumScaleFactor = 0.5 // Минимальный размер шрифта
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.layer.cornerRadius = 8.0
        stackView.layer.borderWidth = 1.0
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    private let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
       
        return button
    }()
    
    @objc private func checkboxTapped() {
        completionTadded?(checkboxButton)
    }
    
    func settingTast(task: Data) {
        label.text = task.text
    }
}
