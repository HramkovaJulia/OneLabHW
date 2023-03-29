//
//  FiveViewController.swift
//  OneTFirst
//
//  Created by Artyom Prima on 29.03.2023.
//

import Foundation
import UIKit

class FiveViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ViewController"
        view.backgroundColor = .white
        settingSubviews()
        setupNavigationFooterButtons(nextSelector: #selector(nextButtonTapped), previusSelector: #selector(backButtonTapped), viewForAdd: gorizontalStackView)
    }
    
    private let labelRed: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    private let labelBlue: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    
    private let  gorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
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
        [labelRed, labelBlue].forEach { label in
            gorizontalStackView.addArrangedSubview(label)
            label.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.4)
            }
        }
        
        gorizontalStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    @objc func nextButtonTapped() {
        let nextVC = ViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func backButtonTapped() {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
        navController.popViewController(animated: true)
    }
    
}
