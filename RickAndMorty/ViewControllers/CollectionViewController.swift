//
//  CollectionViewController.swift
//  RickAndMorty
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
    private var indexPath: IndexPath?
    
    
    
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
        
        // Set the backgroung color for collectionView
        collectionView.backgroundColor = .black
        
        // Setup navigation bar
        UtilityManager.shared.setupNavigationBar(for: self)
        
        // Set the status bar text color to white
        setNeedsStatusBarAppearanceUpdate()
        
        // Getting data from remote server for data model
        NetworkManager.shared.getDataFromRemoteServer(collectionView: collectionView, from: self) { characterResponse in
            self.dataModel = characterResponse
        }
        
    }
    
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
        cell.setupCell(indexPath: indexPath, dataModel: dataModel)
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UtilityManager.shared.changeBackButtonTextAndColor(for: self)
        
        self.indexPath = indexPath
        let selectedCharacter = dataModel.results[indexPath.item]
        showDetailViewController(forCharacter: selectedCharacter)
    }
    
    // MARK: - Navigation
    func showDetailViewController(forCharacter character: Character) {

        let detailsViewController = CharacterDetailsViewController()
        
        //Sending character details to CharacterDetailsViewController
        guard let checkedIndexPath = indexPath else { return }
        detailsViewController.character = dataModel.results[checkedIndexPath.item]
        
        // Perform to CharacterDetailsViewController
        self.navigationController?.pushViewController(detailsViewController, animated: false)
    }
    
}
