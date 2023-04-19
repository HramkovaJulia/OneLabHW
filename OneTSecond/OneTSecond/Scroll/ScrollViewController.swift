//
//  ScrollViewController.swift
//  OneTSecond
//
//  Created by Artyom Prima on 01.04.2023.
//

import UIKit

class ScrollViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        settingSubviews()
    }
    
    private let scrollView = UIScrollView()
    
    private let labelNames = ["Google", "Instagram", "Twitter", "Telegram", "iCloud", "yahoo!", "Outlook.com", "Microsoft Exchange", "Google", "Instagram", "Twitter", "Telegram", "iCloud", "yahoo!", "Outlook.com", "Microsoft Exchange" ]
    
    func settingSubviews() {
        scrollView.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }

           var previousLabel: UILabel?
           for name in labelNames {
               let label = UILabel()
               label.text = name
               label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
               label.textColor = .black
               label.textAlignment = .center
               label.backgroundColor = .lightGray
               label.layer.cornerRadius = 8
               label.layer.borderColor = #colorLiteral(red: 0.58187747, green: 0.6370299459, blue: 0.7215286493, alpha: 1)
               label.layer.borderWidth = 1
               label.clipsToBounds = true
               scrollView.addSubview(label)

               label.snp.makeConstraints { make in
                   make.leading.equalToSuperview().offset(16)
                   make.trailing.equalToSuperview().inset(16)
                   make.height.equalTo(50)
                   make.centerX.equalToSuperview()
                   if let previousLabel = previousLabel {
                       make.top.equalTo(previousLabel.snp.bottom).offset(10)
                   } else {
                       make.top.equalToSuperview()
                   }
               }

               previousLabel = label
           }

        if let lastLabel = previousLabel {
            lastLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
            }
        }
    }
}

