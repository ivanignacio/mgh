//
//  PageCell.swift
//  My Green House
//
//  Created by Ivan Ignacio Lopez Ambrocio on 2018-12-12.
//  Copyright © 2018 Ivan Ignacio Lopez Ambrocio. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell{
    
    var page: Page? {
        didSet{
            guard let unwrappedPage = page else { return }
            image.image = UIImage(named: unwrappedPage.image)
            let attributedText = NSMutableAttributedString(
                string: unwrappedPage.header,
                attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
                attributedText.append(NSAttributedString(
                                string: "\n\n\n\(unwrappedPage.body)",
                                attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
                                             NSAttributedString.Key.foregroundColor : UIColor.gray]))
            descriptionText.attributedText = attributedText
            descriptionText.textAlignment = .center
        }
    }
    
    let image: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionText : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints =  false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout(){
        let topContainerView = UIView()
        
        addSubview(topContainerView)
        addSubview(descriptionText)
        
        topContainerView.translatesAutoresizingMaskIntoConstraints  = false
        topContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        topContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topContainerView.addSubview(image)
        
        image.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        image.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        descriptionText.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        descriptionText.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionText.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    
}
