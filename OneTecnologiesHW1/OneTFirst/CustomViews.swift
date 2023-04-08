//
//  CustomViews.swift
//  OneTFirst
//
//  Created by Artyom Prima on 29.03.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupNavigationFooterButtons(nextSelector: Selector?, previusSelector: Selector?, viewForAdd: UIView) -> UIStackView {
        let previusButton = UIButton()
        previusButton.setTitle("Previous", for: .normal)
        previusButton.setTitleColor(.black, for: .normal)
        
        let informationButton = UIButton()
        informationButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        informationButton.tintColor = .black
        
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        
        if let previusSelector = previusSelector {
            previusButton.addTarget(self, action: previusSelector, for: .touchUpInside)
        }
        
        if let nextSelector = nextSelector {
            nextButton.addTarget(self, action: nextSelector, for: .touchUpInside)
        }
        
        let gorizontalStackView = UIStackView(arrangedSubviews: [previusButton, informationButton, nextButton])
        gorizontalStackView.axis = .horizontal
        gorizontalStackView.distribution = .equalCentering
        
        view.addSubview(gorizontalStackView)
        gorizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(viewForAdd.snp.bottomMargin)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(viewForAdd.snp.width)
            make.bottom.equalTo(view.snp.bottomMargin).offset(16)
        }
        return gorizontalStackView
    }
}

