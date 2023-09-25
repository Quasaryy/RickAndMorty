//
//  NetworkManager.swift
//  RickSndMorty
//
//  Created by Yury on 26/08/2023.
//

import Foundation
import UIKit

class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    
    // MARK: - Init
    private init() {}
    
}

// MARK: - Methods
extension NetworkManager {
    
    func getDataFromRemoteServer(collectionView: UICollectionView, from viewController: UIViewController, completion: @escaping (CharacterResponse) -> Void) {
        
        // Create and show loader
        let loader = UtilityManager.shared.createLoaderViewController()
        DispatchQueue.main.async {
            viewController.present(loader, animated: true, completion: nil)
        }

        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // Hide the loader after the data is loaded and the collection is reloaded
            defer {
                DispatchQueue.main.async {
                    UtilityManager.shared.stopLoader(loader: loader)
                }
            }

            if let error = error {
                Logger.logErrorDescription(error)
                return
            }

            if let response = response {
                Logger.logResponse(response)
            }

            guard let remoteData = data else { return }

            do {
                let dataModel = try JSONDecoder().decode(CharacterResponse.self, from: remoteData)
                DispatchQueue.main.async {
                    completion(dataModel)
                    collectionView.reloadData()
                }
            } catch let error {
                Logger.logErrorDescription(error)
            }
        }.resume()
    }

    
    func getDataFromRemoteServerForLocation(character: Character, tableView: UITableView, completion: @escaping (Location2) -> Void) {
        
        let indexPathToUpdate = IndexPath(row: 0, section: 1)
        guard let url = URL(string: character.origin.url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                Logger.logErrorDescription(error)
                return
            }
            
            if let response = response {
                Logger.logResponse(response)
            }
            
            guard let remoteData = data else { return }
            
            do {
                let dataModelForLocation = try JSONDecoder().decode(Location2.self, from: remoteData)
                DispatchQueue.main.async {
                    completion(dataModelForLocation)
                    tableView.reloadRows(at: [indexPathToUpdate], with: .automatic)
                }
            } catch let error {
                Logger.logErrorDescription(error)
                return
            }
        }.resume()
    }
    
    func getDataFromRemoteServerForEpisodes(character: Character, tableView: UITableView, from viewController: UIViewController, completion: @escaping ([Episode]) -> Void) {
        
        // Create and show loader
        let loader = UtilityManager.shared.createLoaderViewController()
        DispatchQueue.main.async {
            viewController.present(loader, animated: true, completion: nil)
        }
        
        var episodesArray = [String]()
        
        for url in character.episode {
            episodesArray.append(url)
        }
        
        var dataModelForEpisodes = [Episode]()
        let dispatchGroup = DispatchGroup()
        
        for urlEpisode in episodesArray {
            guard let url = URL(string: urlEpisode) else { continue }
            
            dispatchGroup.enter()
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer {
                    dispatchGroup.leave()
                }
                
                if let error = error {
                    Logger.logErrorDescription(error)
                    return
                }
                
                if let response = response {
                    Logger.logResponse(response)
                }
                
                guard let remoteData = data else { return }
                
                do {
                    let newModel = try JSONDecoder().decode(Episode.self, from: remoteData)
                    dataModelForEpisodes.append(newModel)
                    
                } catch let error {
                    Logger.logErrorDescription(error)
                    return
                }
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            UtilityManager.shared.stopLoader(loader: loader)
            completion(dataModelForEpisodes)
            tableView.reloadData()
        }
    }

}


