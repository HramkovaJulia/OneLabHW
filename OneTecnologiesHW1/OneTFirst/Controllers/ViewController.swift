//
//  ViewController.swift
//  OneTFirst
//
//  Created by Artyom Prima on 27.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Simple Stack View"
        settingSubviews()
        setupNavigationFooterButtons(nextSelector: #selector(nextButtonTapped), previusSelector: #selector(backButtonTapped), viewForAdd: verticalFirstStackView)
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Flowers"
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor( .black, for: .normal)
        return button
    }()
    
    private let  verticalFirstStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 10
        stack.spacing = 8
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true // включаем отступы
        stack.clipsToBounds = true
        stack.layer.borderWidth = 1.0
        stack.layer.borderColor = UIColor.black.cgColor
        
        return stack
    }()
    
    @objc func nextButtonTapped() {
        let nextVC = SecondViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func settingSubviews() {
        imageView.image = UIImage(named: "flowers")
        view.backgroundColor = .white
        view.addSubview(verticalFirstStackView)
        
        verticalFirstStackView.addArrangedSubview(label)
        verticalFirstStackView.addArrangedSubview(imageView)
        verticalFirstStackView.addArrangedSubview(editButton)
        
        verticalFirstStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalTo(view.snp_centerXWithinMargins)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            
        }
    }
    
    @objc private func backButtonTapped() {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
        print(navController.viewControllers)
        let lastViewController = navController.viewControllers.last
        if let lastViewController = lastViewController {
            navController.popToViewController(lastViewController, animated: true)
            print("wrong")
        }
    }
}
