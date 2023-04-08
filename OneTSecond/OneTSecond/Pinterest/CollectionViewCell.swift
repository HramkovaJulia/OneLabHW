//
//  CollectionViewCell.swift
//  OneTSecond
//
//  Created by Artyom Prima on 01.04.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        let images: [UIImage] = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3"),
        UIImage(named: "4"),
        UIImage(named: "5"),
        UIImage(named: "6"),
        UIImage(named: "7"),
        UIImage(named: "8"),
        UIImage(named: "9")
        ].compactMap({ $0 })
        imageView.image = images.randomElement()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
