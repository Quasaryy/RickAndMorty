//
//  CharctersModel.swift
//  RickSndMorty
//
//  Created by Yury on 19/08/2023.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]
    static let shared = CharacterResponse(results: [Character]())
}

// Model for chargcters
struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    //static let shared = Character(id: Int(), name: String(), status: String(), species: String(), type: String(), gender: String(), origin: Origin(name: String(), url: String()), location: Location(name: String(), url: String()), image: String(), episode: [String](), url: String(), created: String())
}

struct Origin: Codable {
    let name: String
    let url: String
    let type: String?

}

struct Location: Codable {
    let name: String
    let url: String
}

// Model for edisodes
struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    static let shared = Episode(id: Int(), name: String(), airDate: String(), episode: String(), characters: [String](), url: String(), created: String())

    enum CodingKeys: String, CodingKey {
        case id, name, airDate = "air_date", episode, characters, url, created
    }
}

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
