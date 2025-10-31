//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-16.
//

import Foundation

struct RMCharacter: Codable, Identifiable {
    var id: Int = 0
    var name: String = ""
    var status: String = ""
    var species: String = ""
    var type: String = ""
    var gender: String = ""
    var origin: Origin = Origin(name: "")
    var location: CharacterLocation = CharacterLocation(name: "")
    var image: String = ""
    var episode: [String] = []

}

struct CharacterLocation: Codable {
    let name: String
}

struct Origin: Codable {
    let name: String
}


