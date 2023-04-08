//
//  ContactTableViewCell.swift
//  OneTSecond
//
//  Created by Artyom Prima on 02.04.2023.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    static var identifier = "ContactTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var labelName: UILabel = {
        let labelText = UILabel()
        labelText.numberOfLines = 1
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        labelText.textColor = .black
        return labelText
    }()
    
    private var labelPhone: UILabel = {
        let labelText = UILabel()
        labelText.numberOfLines = 1
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = UIFont.systemFont(ofSize: 13, weight: .light)
        labelText.textColor = .black
        return labelText
    }()
    
    private let stackViewInfoContact: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func addSubviews(){
        contentView.addSubview(stackViewInfoContact)
        stackViewInfoContact.addArrangedSubview(labelName)
//        stackViewInfoContact.addArrangedSubview(labelPhone)
    }
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            stackViewInfoContact.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
              stackViewInfoContact.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
              stackViewInfoContact.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
              stackViewInfoContact.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
          ])
    }
    
    func configContact(contact: InfoContact) {
        labelName.text = contact.name
        labelPhone.text = String(contact.phone)
    }
}
