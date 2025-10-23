//
//  Location.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import Foundation

struct Location: Codable, Identifiable {
    var id: Int = 0
    var name: String = ""
    var type: String = ""
    var dimension: String = ""
    var residents: [String] = []
    var url: String = ""

}
