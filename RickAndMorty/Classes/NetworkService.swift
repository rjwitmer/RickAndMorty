//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-16.
//

import Foundation
import Network

class NetworkService {
    private let monitor: NWPathMonitor = NWPathMonitor()
    private let queue: DispatchQueue = DispatchQueue(label: "NetworkMonitor")
    private var isConnected: Bool = true
    private let rickAndMortyURL: String = "https://rickandmortyapi.com/api"
    var charactersURL: String = "https://rickandmortyapi.com/api/character"
    var episodesURL: String = "https://rickandmortyapi.com/api/episode"
    var locationsURL: String = "https://rickandmortyapi.com/api/location"
    
    init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    func fetchBaseData() async throws -> RickMortyAPI {
        guard isConnected else {
            throw NetworkError.noInternetConnection
        }
        let url = URL(string: "https://rickandmortyapi.com/api")!
        print("URL: \(url)")

        
        let (data, response) = try await URLSession.shared.data(from: url )
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("😡 ERROR: \(NetworkError.apiError)")
            throw NetworkError.apiError
        }
        print("HTTP Status: \(httpResponse.statusCode)")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(RickMortyAPI.self, from: data)
    }
    
    func fetchCharacterData() async throws -> Characters {
        guard isConnected else {
            throw NetworkError.noInternetConnection
        }
        let url = URL(string: charactersURL)!
        print("URL: \(url)")

        
        let (data, response) = try await URLSession.shared.data(from: url )
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("😡 ERROR: \(NetworkError.apiError)")
            throw NetworkError.apiError
        }
        print("HTTP Status: \(httpResponse.statusCode)")
        print("Count: \(data.count)")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Characters.self, from: data)
    }
    
    func fetchLocationData() async throws -> Locations {
        guard isConnected else {
            throw NetworkError.noInternetConnection
        }
        let url = URL(string: locationsURL)!
        print("URL: \(url)")

        
        let (data, response) = try await URLSession.shared.data(from: url )
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("😡 ERROR: \(NetworkError.apiError)")
            throw NetworkError.apiError
        }
        print("HTTP Status: \(httpResponse.statusCode)")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Locations.self, from: data)
    }
    
    func fetchEpisodeData() async throws -> Episodes {
        guard isConnected else {
            throw NetworkError.noInternetConnection
        }
        let url = URL(string: episodesURL)!
        print("URL: \(url)")

        
        let (data, response) = try await URLSession.shared.data(from: url )
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("😡 ERROR: \(NetworkError.apiError)")
            throw NetworkError.apiError
        }
        print("HTTP Status: \(httpResponse.statusCode)")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Episodes.self, from: data)
    }
}

enum NetworkError: Error, LocalizedError {
    case noInternetConnection
    case apiError
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        case .apiError:
            return "An error occurred while fetching data from the REST API. Please try again later."
        }
    }
}
