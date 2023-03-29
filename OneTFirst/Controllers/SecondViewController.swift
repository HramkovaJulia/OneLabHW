//
//  SecondViewController.swift
//  OneTFirst
//
//  Created by Artyom Prima on 28.03.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nested Stack View"
        view.backgroundColor = .white
        settingSubviews()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        previusButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private let labelNames = ["First", "Middle", "Last"]
    
    private let textFields = ["Enter First Name", "Enter Middle Name", "Enter Last Name"]
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "flowers"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let verticalLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let firstTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter First Name"
        return textField
        
    }()
    
    private let middleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Middle Name"
        return textField
        
    }()
    
    private let lastTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Last Name"
        return textField
        
    }()
    
    private let notesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Notes:"
        textField.backgroundColor = .systemGray
        return textField
    }()
    
    private let verticalTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let gorizontalHeaderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let verticalFirstStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true // включаем отступы
        stack.clipsToBounds = true
        stack.layer.borderWidth = 1.0
        stack.layer.borderColor = UIColor.black.cgColor
        return stack
    }()
    
    private let verticalSecondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        return stackView
    }()
    
    private let gorizontalButtonFisrtStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let gorizontalButtonSecondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        return button
    }()
    
    private let previusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Prevoius", for: .normal)
        button.setTitleColor( .black, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor( .black, for: .normal)
        
        return button
    }()
    
    private let informationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = UIColor.black
        return button
    }()
    
    @objc func nextButtonTapped() {
        let nextVC = ThirdViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func settingSubviews(){
        view.addSubview(verticalLabelStackView)
        view.addSubview(verticalTextFieldStackView)
        view.addSubview(gorizontalHeaderStackView)
        view.addSubview(verticalFirstStackView)
        view.addSubview(verticalSecondStackView)
        
        labelNames.forEach { name in
            let label = UILabel()
            label.text = name
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            label.textColor = .black
            label.textAlignment = .left
            verticalLabelStackView.addArrangedSubview(label)
        }
        
        [firstTextField, middleTextField, lastTextField].forEach { textField in
            textField.borderStyle = UITextField.BorderStyle.roundedRect
            textField.textColor = .lightGray
            textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth = 1
            textField.returnKeyType = .done
            textField.becomeFirstResponder()
            verticalTextFieldStackView.addArrangedSubview(textField)
        }
        
        [imageView, verticalLabelStackView, verticalTextFieldStackView].forEach { view in
            gorizontalHeaderStackView.addArrangedSubview(view)
        }
        
        [previusButton, informationButton, nextButton].forEach { button in
            gorizontalButtonSecondStackView.addArrangedSubview(button )
        }
        
        [saveButton, cancelButton, clearButton].forEach { button in
            button.setTitleColor( .black, for: .normal)
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 16, weight: .regular)
            gorizontalButtonFisrtStackView.addArrangedSubview(button)
        }
        
        [gorizontalHeaderStackView, notesTextField, gorizontalButtonFisrtStackView].forEach { view in
            verticalFirstStackView.addArrangedSubview(view)
        }
        
        [verticalFirstStackView, gorizontalButtonSecondStackView].forEach { stackView in
            verticalSecondStackView.addArrangedSubview(stackView)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        notesTextField.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(150)
            make.height.lessThanOrEqualTo(view.frame.size.height/2)
        }
        
        gorizontalHeaderStackView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        verticalFirstStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.leading.equalTo(view.snp.leadingMargin).offset(6)
        }
        
        verticalSecondStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin).offset(16)
            make.bottom.equalTo(view.snp_bottomMargin).offset(-16)
        }
    }
    
    @objc private func backButtonTapped() {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
        navController.popViewController(animated: true)
    }
    
}
