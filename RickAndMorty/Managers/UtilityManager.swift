//
//  UtilityManager.swift
//  RickSndMorty
//
//  Created by Yury on 26/08/2023.
//

import UIKit

class UtilityManager {
    
    // MARK: - Properties
    
    static let shared = UtilityManager()
    
    // MARK: - Init
    
    // Private initializer to prevent new instances of the class from being created
    private init() {}
    
}

// MARK: - Methods

extension UtilityManager {
    
    // Converting seasons and episodes to neeed format
    func convertEpisodeString(_ episodeString: String) -> String {
        let components = episodeString.components(separatedBy: "E")
        if components.count == 2 {
            let season = Int(components[0].dropFirst()) ?? 0
            let episode = Int(components[1]) ?? 0
            return "Episode: \(episode), Season: \(season)"
        }
        return "Wrong format"
    }
    
    // Setup header section for text color, font, spacers
    func setupHederForSection(name: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .clear // Прозрачный фон, чтобы не перекрывать ячейки
        
        let label = UILabel()
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.topAnchor, constant: 35)
        ])
        
        return headerView
    }
    
    // MARK: Loader section
    
    func createLoaderViewController() -> UIAlertController {
        let alert = UIAlertController(title: "Please wait", message: "Loading character", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 15, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
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
    
    func setupNavigationBar(for viewController: UIViewController) {
        viewController.title = "Characters"
        viewController.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        viewController.navigationController?.navigationBar.standardAppearance = appearance
        viewController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // Setup back button for navigation bar
    func changeBackButtonTextAndColor(for viewController: UIViewController) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .white
        viewController.navigationItem.backBarButtonItem = backButton
    }
    
}
