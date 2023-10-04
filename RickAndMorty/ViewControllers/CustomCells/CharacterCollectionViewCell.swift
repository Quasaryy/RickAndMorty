//
//  CollectionViewCell.swift
//  RickAndMorty
//
//  Created by Yury on 19/08/2023.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var characterImageView: UIImageView = {
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
        charcterName.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        charcterName.textAlignment = .center
        charcterName.numberOfLines = 1
        charcterName.lineBreakMode = .byTruncatingTail
        contentView.addSubview(charcterName)
        
        // Setting constraints for a lablel
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
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        // Set background for a cell
        self.contentView.backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1)
    }
    
    // MARK: - Required init
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Methods

extension CharacterCollectionViewCell {
    
    // Setup the cell
    func setupCell(indexPath: IndexPath, dataModel: CharacterResponse) {
        
        let character = dataModel.results[indexPath.item]
        
        // Loading image (in async mode)
        if let imageURL = URL(string: character.image) {
            UtilityManager.shared.loadImageAsync(from: imageURL) { image in
                DispatchQueue.main.async {
                    self.characterImageView.image = image
                }
            }
        }
        
        charcterName.text = character.name
    }
    
}
