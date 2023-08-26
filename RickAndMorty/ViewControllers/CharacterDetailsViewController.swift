//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Yury on 20/08/2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Propertis
    var character: Character!
    private var dataModelForLocation = Location2.shared
    private var dataModelForEpisodes = [Episode.shared]
    
    lazy private var characterNameImage: UIImageView = {
        characterNameImage = UIImageView()
        characterNameImage.contentMode = .scaleAspectFill
        characterNameImage.layer.cornerRadius = 16
        characterNameImage.layer.masksToBounds = true
        view.addSubview(characterNameImage)
        
        return characterNameImage
    }()
    
    lazy private var characterName: UILabel = {
        characterName = UILabel()
        characterName.text = character.name
        characterName.textColor = UIColor.white
        characterName.font = UIFont(name: "Gilroy-Bold", size: 22)
        characterName.textAlignment = .center
        characterName.numberOfLines = 1
        characterName.lineBreakMode = .byTruncatingTail
        self.view.addSubview(characterName)
        
        return characterName
    }()
    
    lazy private var characterAlive: UILabel = {
        characterAlive = UILabel()
        characterAlive.text = character.status
        switch character.status {
            case "Alive":
                characterAlive.textColor = UIColor(red: 71/255, green: 198/255, blue: 11/255, alpha: 1)
            case "unknown":
                characterAlive.textColor = UIColor.gray
            default:
                characterAlive.textColor = UIColor.red
        }
        characterAlive.font = UIFont(name: "Gilroy-Medium", size: 16)
        characterAlive.textAlignment = .center
        characterAlive.numberOfLines = 1
        characterAlive.lineBreakMode = .byTruncatingTail
        self.view.addSubview(characterAlive)
        
        return characterAlive
    }()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        view.addSubview(tableView)
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        
        NetworkManager.shared.getDataFromRemoteServerForLocation(character: character, tableView: tableView) { locationData in
            self.dataModelForLocation = locationData
        }
        NetworkManager.shared.getDataFromRemoteServerForEpisodes(character: character, tableView: tableView,from: self) { episodesData in
            self.dataModelForEpisodes = episodesData
        }
        
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "infoCell")
        tableView.register(OriginTableViewCell.self, forCellReuseIdentifier: "originCell")
        tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: "episodesCell")
        
        view.backgroundColor = .black
        setNeedsStatusBarAppearanceUpdate() // Set the status bar text color to white
        
        // Load character image
        if let imageUrl = URL(string: character.image) {
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.characterNameImage.image = image
                    }
                }
            }.resume()
        }
        
        addConstaraints()
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return character.episode.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
            
            // Configure the cell
            infoCell.setupInfoCell(character: character)
            
            return infoCell
            
        } else if indexPath.section == 1 {
            
            let originCell = tableView.dequeueReusableCell(withIdentifier: "originCell", for: indexPath) as! OriginTableViewCell
            
            // Configure the cell
            originCell.setupInfoCell(dataModel: dataModelForLocation)
            
            return originCell
            
        } else {
            
            let episodesCell = tableView.dequeueReusableCell(withIdentifier: "episodesCell", for: indexPath) as! EpisodesTableViewCell
            
            // Configure the cell
            episodesCell.setupEpisodesCell(dataModel: dataModelForEpisodes, indexPath: indexPath)
            
            return episodesCell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        UIView.animate(withDuration: 0.2, animations: {
            cell?.contentView.backgroundColor = UIColor(red: 53/255, green: 54/255, blue: 54/255, alpha: 1)
        }) { (_) in
            UIView.animate(withDuration: 0.2, animations: {
                cell?.contentView.backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1)
            })
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UtilityManager.shared.setupHederForSection(name: "Info")
        } else if section == 1 {
            return UtilityManager.shared.setupHederForSection(name: "Origin")
        } else if section == 2  {
            return UtilityManager.shared.setupHederForSection(name: "Episodes")
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (0...2) ~= section {
            return 50
        }
        return 0.1
    }
    
}


// MARK: - Private Methods
extension CharacterDetailsViewController {
    private func addConstaraints() {
        
        // Setting constraints for an image
        characterNameImage.translatesAutoresizingMaskIntoConstraints = false
        characterNameImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        characterNameImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        characterNameImage.heightAnchor.constraint(equalToConstant: 148).isActive = true
        characterNameImage.widthAnchor.constraint(equalToConstant: 148).isActive = true
        
        // Constarints for character name
        characterName.translatesAutoresizingMaskIntoConstraints = false
        characterName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        characterName.topAnchor.constraint(equalTo: characterNameImage.bottomAnchor, constant: 30).isActive = true
        characterName.heightAnchor.constraint(equalToConstant: 22).isActive = true
        characterName.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
        // Constarints for character alive
        characterAlive.translatesAutoresizingMaskIntoConstraints = false
        characterAlive.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        characterAlive.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 10).isActive = true
        characterAlive.heightAnchor.constraint(equalToConstant: 22).isActive = true
        characterAlive.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        // Constarints for table view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: characterAlive.topAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
}
