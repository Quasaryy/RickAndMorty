//
//  EpisodesTableViewCell.swift
//  RickAndMorty
//
//  Created by Yury on 21/08/2023.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: Episode name
    let episodeName: UILabel = {
        let episodeName = UILabel()
        episodeName.translatesAutoresizingMaskIntoConstraints = false
        episodeName.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        episodeName.textColor = UIColor.white
        episodeName.numberOfLines = 1
        episodeName.lineBreakMode = .byTruncatingTail
        return episodeName
    }()
    
    // MARK: Episode number
    let episodeNumber: UILabel = {
        let episodeNumber = UILabel()
        episodeNumber.translatesAutoresizingMaskIntoConstraints = false
        episodeNumber.font = UIFont(name: "Gilroy-Medium", size: 13)
        episodeNumber.textColor = UIColor(red: 71/255, green: 198/255, blue: 11/255, alpha: 1)
        return episodeNumber
    }()
    
    // MARK: Episode name
    let edisodeDate: UILabel = {
        let edisodeDate = UILabel()
        edisodeDate.translatesAutoresizingMaskIntoConstraints = false
        edisodeDate.font = UIFont(name: "Gilroy-Medium", size: 12)
        edisodeDate.textColor = UIColor(red: 147/255, green: 152/255, blue: 156/255, alpha: 1)
        edisodeDate.textAlignment = .right
        return edisodeDate
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(episodeName)
        contentView.addSubview(episodeNumber)
        contentView.addSubview(edisodeDate)
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            // Episode name
            episodeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            episodeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            episodeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Episode number
            episodeNumber.topAnchor.constraint(equalTo: episodeName.bottomAnchor, constant: 16),
            episodeNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Episode date
            edisodeDate.topAnchor.constraint(equalTo: episodeName.bottomAnchor, constant: 16),
            edisodeDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            edisodeDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    // MARK: - Required init
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
extension EpisodesTableViewCell {
    
    // Setup the call
    func setupEpisodesCell(dataModel: [Episode], indexPath: IndexPath) {
        selectionStyle = .none
        backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1)
        
        let episodeIndex = indexPath.section - 2
        
        if episodeIndex >= 0 && episodeIndex < dataModel.count {
            
            let episodeString = dataModel[episodeIndex].episode
            episodeName.text = dataModel[episodeIndex].name
            episodeNumber.text = UtilityManager.shared.convertEpisodeString(episodeString)
            edisodeDate.text = dataModel[episodeIndex].airDate
        } else {
            episodeName.text = "Loading..."
            episodeNumber.text = "Loading..."
            edisodeDate.text = "Loading..."
        }
    }
    
}

