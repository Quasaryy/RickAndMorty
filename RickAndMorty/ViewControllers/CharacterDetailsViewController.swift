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
    private var dataModel = Location2.shared
    
    
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
        getDataFromRemoteServer()
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "infoCell")
        tableView.register(OriginTableViewCell.self, forCellReuseIdentifier: "originCell")
        
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
        return 2 + character.episode.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1)
            cell.leftLabel1.text = "Species:"
            cell.leftLabel2.text = "Type:"
            cell.leftLabel3.text = "Gender:"
            cell.rightLabel1.text = character.species
            
            character.type == "" ? (cell.rightLabel2.text = "None") : (cell.rightLabel2.text = character.type)
            
            cell.rightLabel3.text = character.gender
            
            return cell
        } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "originCell", for: indexPath) as! OriginTableViewCell
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1)
            cell.planetImage.image = UIImage(named: "planet")
            dataModel.name != "" ? (cell.locationName.text = dataModel.name) : (cell.locationName.text = "Unknow")
            dataModel.type != "" ? (cell.planetName.text = dataModel.type) : (cell.planetName.text = "Unknow")
               
                
                return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
            
            cell.leftLabel1.text = "asd"
            cell.leftLabel2.text = "asd"
            cell.leftLabel3.text = "asd"
            
            cell.rightLabel1.text = "Right Label 1"
            cell.rightLabel2.text = "Right Label 2"
            cell.rightLabel3.text = "Right Label 3"
            
            return cell
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
    
    // MARK: Network section
    func getDataFromRemoteServer() {
        guard let url = URL(string: character.origin.url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.alert(title: "Something wrong", message: error.localizedDescription)
                }
                return
            }
            
            if let response = response {
                print(response)
            }
            
            guard let remtoteData = data else { return }
            do {
                self.dataModel = try JSONDecoder().decode(Location2.self, from: remtoteData)
                //print(self.dataModel)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    let loader = self.loader()
                    self.stopLoader(loader: loader)
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    let loader = self.loader()
                    self.stopLoader(loader: loader)
                    self.alert(title: "Remote data decoding error", message: "We are working on fixing the bug, please try again later.")
                }
            }
        }.resume()
    }
    
    // MARK: Alert controller
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "OK", style: .default)
        alert.addAction(buttonOK)
        present(alert, animated: true)
    }
    
    // To load images in async mode
    func loadImageAsync(from imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("Error image loading: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    // MARK: Loader section
    private func loader() -> UIAlertController {
        let alert = UIAlertController(title: "Please wait", message: "Loading characters", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 15, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    private func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
}
