//
//  Episode.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import Foundation

struct Episode: Codable, Identifiable {
    var id: Int = 0
    var name: String = ""
    var air_date: String = ""
    var episode: String = ""
    var characters: [String] = []
    var url: String = ""

}
