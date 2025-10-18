//
//  RickMortyVM.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-16.
//

import Foundation

@MainActor
class RickMortyVM: Observable {    
    private var charactersURL: String = ""
    private var episodesURL: String = ""
    private var locationsURL: String = ""
    private var errorMessage: String?
    
    
    private let networkService: NetworkService = NetworkService()
    var isLoading: Bool = false
    
    func getData() {
        self.isLoading = true
        Task {
            do {
                let decodedData = try await networkService.fetchBaseData()
                DispatchQueue.main.async {
                    if decodedData.characters.isEmpty {
                        print("😡 ERROR: No API data")
                    } else {
                        self.charactersURL = decodedData.characters
                        self.locationsURL = decodedData.locations
                        self.episodesURL = decodedData.episodes
                        print("Characters URL: \(self.charactersURL)")
                        print("Locations URL: \(self.locationsURL)")
                        print("Episodes URL: \(self.episodesURL)")
                        self.isLoading = false
                    }

                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "😡 ERROR: Problem fetching data: \(error.localizedDescription)"
                }
            }
        }
    }
}
