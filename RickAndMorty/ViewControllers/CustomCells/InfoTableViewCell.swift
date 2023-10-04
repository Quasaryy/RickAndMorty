//
//  InfoTableViewCell.swift
//  RickAndMorty
//
//  Created by Yury on 20/08/2023.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let fontGilroyMedium = "Gilroy-Medium"
    
    // MARK: Right lables
    lazy var leftLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 196/255, green: 201/255, blue: 206/255, alpha: 1)
        label.font = UIFont(name: fontGilroyMedium, size: 16)
        return label
    }()
    
    lazy var leftLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 196/255, green: 201/255, blue: 206/255, alpha: 1)
        label.font = UIFont(name: fontGilroyMedium, size: 16)
        return label
    }()
    
    lazy var leftLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 196/255, green: 201/255, blue: 206/255, alpha: 1)
        label.font = UIFont(name: fontGilroyMedium, size: 16)
        return label
    }()
    
    // MARK: Right lables
    lazy var rightLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: fontGilroyMedium, size: 16)
        label.textAlignment = .right
        return label
    }()
    
    lazy var rightLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: fontGilroyMedium, size: 16)
        label.textAlignment = .right
        return label
    }()
    
    lazy var rightLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: fontGilroyMedium, size: 16)
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: - Add left labels to a cell
        
        let leftStackView = UIStackView(arrangedSubviews: [leftLabel1, leftLabel2, leftLabel3])
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .vertical
        leftStackView.spacing = 20
        contentView.addSubview(leftStackView)
        
        // MARK: - Add right labels to a cell
        
        let rightStackView = UIStackView(arrangedSubviews: [rightLabel1, rightLabel2, rightLabel3])
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.axis = .vertical
        rightStackView.spacing = 20
        contentView.addSubview(rightStackView)
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            leftStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            rightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            rightStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Required init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension InfoTableViewCell {
    
    // Setup the cell
    func setupInfoCell(character: Character) {
        selectionStyle = .none
        backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1)
        
        leftLabel1.text = "Species:"
        leftLabel2.text = "Type:"
        leftLabel3.text = "Gender:"
        
        rightLabel1.text = character.species
        character.type.isEmpty ? (rightLabel2.text = "None") : (rightLabel2.text = character.type)
        rightLabel3.text = character.gender
    }
    
}
