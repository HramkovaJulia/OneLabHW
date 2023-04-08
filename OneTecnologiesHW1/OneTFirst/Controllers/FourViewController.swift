//
//  FourViewController.swift
//  OneTFirst
//
//  Created by Artyom Prima on 29.03.2023.
//

import UIKit

class FourViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Image Views and Aspect Ratio Constraints"
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
    
    private let labelThird: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    
    private let labelFour: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "flowers")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let  gorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    private let  verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 16
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true // включаем отступы
        stack.clipsToBounds = true
        stack.layer.borderWidth = 1.0
        stack.layer.borderColor = UIColor.black.cgColor
        
        return stack
    }()
    
    func settingSubviews() {
        view.addSubview(gorizontalStackView)
        view.addSubview(verticalStackView)
        [labelFirst, imageView, labelSecond].forEach { views in
            gorizontalStackView.addArrangedSubview(views)
        }
        
        [labelThird, gorizontalStackView, labelFour].forEach { views in
            verticalStackView.addArrangedSubview(views)
        }
        
        [labelFirst, labelSecond].forEach { label in
            label.snp.makeConstraints { make in
                make.height.lessThanOrEqualTo(view.frame.size.height/3)
                make.width.greaterThanOrEqualTo(50)
                make.width.lessThanOrEqualTo(100)
            }
        }
        
        [labelThird, labelFour].forEach { label in
            label.snp.makeConstraints { make in
                make.height.greaterThanOrEqualTo(100)
                make.height.lessThanOrEqualTo(150)
            }
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.greaterThanOrEqualTo(view.frame.size.height/3)
            make.height.lessThanOrEqualTo(view.frame.size.height/2.5)
        }
    }
    
    @objc func nextButtonTapped() {
        let nextVC = FiveViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func backButtonTapped() {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
        navController.popViewController(animated: true)
    }
    
}
