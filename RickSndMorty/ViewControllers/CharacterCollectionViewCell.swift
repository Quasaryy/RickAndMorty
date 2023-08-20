//
//  CollectionViewCell.swift
//  RickSndMorty
//
//  Created by Yury on 19/08/2023.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy var characterImageView: UIImageView! = {
        characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.masksToBounds = true
        contentView.addSubview(characterImageView)
        
        // Setting constraints for an image
        characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        return characterImageView
    }()
    
    lazy var charcterName: UILabel = {
        charcterName = UILabel()
        charcterName.translatesAutoresizingMaskIntoConstraints = false
        charcterName.textColor = UIColor.white
        charcterName.font = UIFont(name: "Gilroy-Bold", size: 17)
        charcterName.textAlignment = .center
        charcterName.numberOfLines = 1
        charcterName.lineBreakMode = .byTruncatingTail
        contentView.addSubview(charcterName)
        
        // Setting constraints for an lablel
        charcterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        charcterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        charcterName.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 15).isActive = true
        charcterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        charcterName.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        return charcterName
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set corner rounding for a cell
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        // Set background for a cell
        self.contentView.backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
