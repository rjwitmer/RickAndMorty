//
//  Characters.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-17.
//

import Foundation

struct Characters: Codable, Identifiable {
    let id: String = UUID().uuidString
    var info: Info = Info(count: 0, pages: 0, next: "")
    var results: [Character] = []
    
    enum CodingKeys: CodingKey {
        case info
        case results
    }
}

struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String?
//    var prev: String? // Not used in my code
}
