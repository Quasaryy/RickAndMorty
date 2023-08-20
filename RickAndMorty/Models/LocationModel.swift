//
//  LocationModel.swift
//  RickSndMorty
//
//  Created by Yury on 20/08/2023.
//

import Foundation

struct Location2: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    static let shared = Location2(id: Int(), name: String(), type: String(), dimension: String(), residents: [String](), url: String(), created: String())
}
