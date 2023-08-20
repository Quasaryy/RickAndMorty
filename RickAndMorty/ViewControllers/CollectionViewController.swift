//
//  CollectionViewController.swift
//  RickSndMorty
//
//  Created by Yury on 19/08/2023.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    private let reuseIdentifier = "Cell"
    private var dataModel = CharacterResponse.shared
    private let cellsInRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 20)
    
    
    
    // MARK: - Initializers
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom UICollectionViewCell class
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.backgroundColor = .black // Set the backgroung color for viewCollection
        setNeedsStatusBarAppearanceUpdate() // Set the status bar text color to white
        setupNavigationBar()
        
        getDataFromRemoteServer()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Creating and casting a cell as custom cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        
        // Configure the cell
        let character = dataModel.results[indexPath.row]
        
        // Loading image (in async mode)
        if let imageURL = URL(string: character.image) {
            loadImageAsync(from: imageURL) { image in
                DispatchQueue.main.async {
                    cell.characterImageView.image = image
                }
            }
        }
        
        cell.charcterName.text = character.name
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    // Setting cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width
        let cellSize: CGFloat = (availableWidth - sectionInsets.left * (cellsInRow + 1)) / cellsInRow
        let size = CGSize(width: cellSize, height: 202)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.top
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.top
    }
    
}

// MARK: - Private Methods
extension CollectionViewController {
    
    // MARK: Network section
    func getDataFromRemoteServer() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
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
                self.dataModel = try JSONDecoder().decode(CharacterResponse.self, from: remtoteData)
                //print(self.dataModel)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
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
    
    // MARK: Navigation bar
    private func setupNavigationBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appereance = UINavigationBarAppearance()
        appereance.backgroundColor = .black
        appereance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appereance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appereance
        navigationController?.navigationBar.scrollEdgeAppearance = appereance
        
    }
    
    // MARK: Loader dection
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
    
    func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
}
