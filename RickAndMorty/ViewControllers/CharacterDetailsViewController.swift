//
//  CharacterDetailsViewController.swift
//  RickSndMorty
//
//  Created by Yury on 20/08/2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Propertis
    var character: Character!
    private let reuseIdentifier = "Cell"
    
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
    
    override func viewDidLoad() {
        
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
        
        for subview in view.subviews {
            if subview == characterName {
                print("charcterName был успешно добавлен к иерархии представлений.")
            }
        }
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 + character.episode.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        // Configure content.
        content.image = UIImage(systemName: "person.crop.circle")
        content.text = "Favorites"
        
        // Customize appearance.
        content.imageProperties.tintColor = .systemCyan
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return setupHederForSection(name: "Info")
        } else if section == 1 {
            return setupHederForSection(name: "Origin")
        } else if section == 2  {
            return setupHederForSection(name: "Episodes")
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
    
    // Setup header section for text color, font, spacers
    private func setupHederForSection(name: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .clear // Transparent background so as not to overlap the cells
        
        let label = UILabel()
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.topAnchor, constant: 35),
        ])
        
        return headerView
    }
    
}
