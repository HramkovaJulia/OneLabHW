//
//  NewContactViewController.swift
//  OneTSecond
//
//  Created by Artyom Prima on 02.04.2023.
//

import UIKit

class NewContactViewController: UIViewController {

    var didCreateNewContact: ((InfoContact)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setConstraints()
        view.backgroundColor = .white
    }
    
    private var nameTextField: UITextField = {
        let textFieldTitle = UITextField()
        textFieldTitle.placeholder = " Enter your name"
        textFieldTitle.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textFieldTitle.returnKeyType = .done
        textFieldTitle.layer.cornerRadius = 4
        textFieldTitle.layer.masksToBounds = true
        textFieldTitle.layer.borderColor = UIColor.black.cgColor
        textFieldTitle.layer.borderWidth = 1.0
        
        return textFieldTitle
    }()
    
    private var phoneTextField: UITextField = {
        let textFieldTitle = UITextField()
        textFieldTitle.placeholder = " Enter phone number"
        textFieldTitle.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textFieldTitle.returnKeyType = .done
        textFieldTitle.keyboardType = .numberPad
        textFieldTitle.layer.cornerRadius = 4
        textFieldTitle.layer.masksToBounds = true
        textFieldTitle.layer.borderColor = UIColor.black.cgColor
        textFieldTitle.layer.borderWidth = 1.0
        return textFieldTitle
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .gray
        
        button.addTarget(nil, action: #selector(saveContact), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private let stackViewTextField: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 26
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    @objc func saveContact(){
        guard
            let name = nameTextField.text,
            let phone = phoneTextField.text else {return}
        let newContact =  InfoContact(
            name: name,
            phone: phone
        )
        didCreateNewContact?(newContact)
        navigationController?.popViewController(animated: true)
    }
    
    func addSubview(){
        view.addSubview(stackViewTextField)
        stackViewTextField.addArrangedSubview(nameTextField)
        stackViewTextField.addArrangedSubview(phoneTextField)
        view.addSubview(saveButton)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackViewTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),
            stackViewTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            stackViewTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -26),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
        ])
    }

}
