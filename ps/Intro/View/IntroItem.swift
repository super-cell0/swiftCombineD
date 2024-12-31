//
//  IntroItem.swift
//  ps
//
//  Created by chen on 2024/11/14.
//

import UIKit
import Combine

class IntroItem: UICollectionViewCell {
    
    let iImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var subscriptions: [AnyCancellable] = []
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        subscriptions = []
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(iImageView)
        iImageView.translatesAutoresizingMaskIntoConstraints = false
        iImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        iImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        iImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        iImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
}
