//
//  InfoTableViewCell.swift
//  RickSndMorty
//
//  Created by Yury on 20/08/2023.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    // Левые лейблы
    let leftLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 196/255, green: 201/255, blue: 206/255, alpha: 1)
        label.font = UIFont(name: "Gilroy-Medium", size: 16)
        return label
    }()
    
    let leftLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 196/255, green: 201/255, blue: 206/255, alpha: 1)
        label.font = UIFont(name: "Gilroy-Medium", size: 16)
        return label
    }()
    
    let leftLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 196/255, green: 201/255, blue: 206/255, alpha: 1)
        label.font = UIFont(name: "Gilroy-Medium", size: 16)
        return label
    }()
    
    // Правые лейблы
    let rightLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Gilroy-Medium", size: 16)
        label.textAlignment = .right
        return label
    }()
    
    let rightLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Gilroy-Medium", size: 16)
        label.textAlignment = .right
        return label
    }()
    
    let rightLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Gilroy-Medium", size: 16)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Добавьте левые лейблы в ячейку
        let leftStackView = UIStackView(arrangedSubviews: [leftLabel1, leftLabel2, leftLabel3])
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .vertical // Изменил на вертикальную ориентацию
        leftStackView.spacing = 20
        contentView.addSubview(leftStackView)
        
        // Добавьте правые лейблы в ячейку
        let rightStackView = UIStackView(arrangedSubviews: [rightLabel1, rightLabel2, rightLabel3])
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.axis = .vertical // Изменил на вертикальную ориентацию
        rightStackView.spacing = 20
        contentView.addSubview(rightStackView)
        
        // Установите констрейнты для стековых представлений
        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            leftStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            rightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            rightStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

