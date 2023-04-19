//
//  ThirdViewController.swift
//  OneTFirst
//
//  Created by Artyom Prima on 29.03.2023.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image Views and Aspect Fit Mode"
        view.backgroundColor = .white
        settingSubviews()
        setupNavigationFooterButtons(nextSelector: #selector(nextButtonTapped), previusSelector: #selector(backButtonTapped), viewForAdd: verticalStackView)
    }
    
    private let labelFirst: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    
    private let labelSecond: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "flowers")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemGray
        return image
    }()
    
    private let  verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true // включаем отступы
        stack.clipsToBounds = true
        stack.layer.borderWidth = 1.0
        stack.layer.borderColor = UIColor.black.cgColor
        
        return stack
    }()
    
    private let  gorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering

        return stack
    }()
    
    func settingSubviews() {
        view.addSubview(verticalStackView)
        
        [labelFirst, labelSecond].forEach { label in
            label.snp.makeConstraints { make in
                make.height.greaterThanOrEqualTo(60)
                make.height.lessThanOrEqualTo(100)
            }
        }
        
        [labelFirst, imageView, labelSecond].forEach { view in
            verticalStackView.addArrangedSubview(view)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    @objc func nextButtonTapped() {
        let nextVC = FourViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc private func backButtonTapped() {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
        navController.popViewController(animated: true)
    }
    
    
}
