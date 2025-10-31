//
//  CharacterVM.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-17.
//

import Foundation

@Observable
class CharacterVM {
    var characters: [RMCharacter] = []
    var count: Int = 0
    var pages: Int = 0
    var next: String?
    var errorMessage: String?
    
    private var networkService: NetworkService = NetworkService()
    var allDataLoaded = false
    var isLoading: Bool = false
    var dataURL: String = "https://rickandmortyapi.com/api/character"
    
    func getData() {
        guard dataURL.hasPrefix("http") else { return }
        self.isLoading = true
        
        Task {
            do {
                let decodedData = try await networkService.fetchCharacterData(dataURL: dataURL)
                DispatchQueue.main.async {
                    if decodedData.info.count == 0 {
                        print("😡 ERROR: No API data")
                    } else {
                        print("👻 Got data")
                        self.count = decodedData.info.count
                        self.pages = decodedData.info.pages
                        self.next = decodedData.info.next
                        self.characters.append(contentsOf: decodedData.results)
                        print("Total Characters: \(self.count)")
                        print("Total Pages: \(self.pages)")
                        print("Next Page URL: \(self.next ?? "")")
                        print("Characters: \(self.characters.count)")
                        self.dataURL = self.next ?? ""
                        self.isLoading = false
                    }
                    
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "😡 ERROR: Problem fetching data: \(error.localizedDescription)"
                    print("😡 ERROR: Problem fetching data: \(error.localizedDescription)")
                }
            }
        }
    }
    func loadNextPage() async {
        //        print(dataURL)
        guard dataURL.hasPrefix("http") else { return }
        getData()
    }
    
    func loadAll() async {
        Task {
            try await Task.sleep(nanoseconds: 500_000_000)
            guard dataURL.hasPrefix("http") else {
                allDataLoaded = true
                return
            }
            getData()
            await loadAll()
        }
    }
}

