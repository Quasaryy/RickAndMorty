//
//  OriginTableViewCell.swift
//  RickAndMorty
//
//  Created by Yury on 20/08/2023.
//

import UIKit

class OriginTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: UIView
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 25/255, green: 28/255, blue: 42/255, alpha: 1)
        return view
    }()
    
    // MARK: Planet image
    let planetImage: UIImageView = {
        let planetImage = UIImageView()
        planetImage.translatesAutoresizingMaskIntoConstraints = false
        planetImage.contentMode = .scaleAspectFit
        return planetImage
    }()
    
    // MARK: Location name
    let locationName: UILabel = {
        let locationName = UILabel()
        locationName.translatesAutoresizingMaskIntoConstraints = false
        locationName.textColor = UIColor.white
        locationName.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        locationName.numberOfLines = 1
        locationName.lineBreakMode = .byClipping
        return locationName
    }()
    
    // MARK: Planet name
    let planetName: UILabel = {
        let planetName = UILabel()
        planetName.translatesAutoresizingMaskIntoConstraints = false
        planetName.font = UIFont(name: "Gilroy-Medium", size: 13)
        planetName.textColor = UIColor(red: 71/255, green: 198/255, blue: 11/255, alpha: 1)
        return planetName
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.addSubview(planetImage)
        contentView.addSubview(locationName)
        contentView.addSubview(planetName)
        
        // MARK: - Constraints
        
        let containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 64)
        containerViewHeightConstraint.priority = .defaultHigh
        containerViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            // UIView
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.widthAnchor.constraint(equalToConstant: 64),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Image inside UIView
            planetImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            planetImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            planetImage.widthAnchor.constraint(equalToConstant: 24),
            planetImage.heightAnchor.constraint(equalToConstant: 24),
            
            // Label for location name
            locationName.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16),
            locationName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            locationName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            // Label for planet name
            planetName.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16),
            planetName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            planetName.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: 12)
        ])
    }
    
    // MARK: - Required init
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension OriginTableViewCell {
    
    // Setup the cell
    func setupInfoCell(dataModel: Location2) {
        selectionStyle = .none
        backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1)
        
        planetImage.image = UIImage(named: "planet")
        locationName.text = dataModel.name.isEmpty ? "Unknown" : dataModel.name
        planetName.text = dataModel.type.isEmpty ? "Unknown" : dataModel.type
    }
    
}
