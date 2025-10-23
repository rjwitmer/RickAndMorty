//
//  Episodes.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import Foundation

struct Episodes: Codable, Identifiable {
    let id: String = UUID().uuidString
    var info: Info = Info(count: 0, pages: 0, next: "")
    var results: [Episode] = []
    
    enum CodingKeys: CodingKey {
        case info
        case results
    }
}
