//
//  CharacterVM.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-17.
//

import Foundation
internal import Combine

class CharacterVM: ObservableObject {
    @Published var characters: [Character] = []
    @Published var count: Int = 0
    @Published var pages: Int = 0
    @Published var next: String?
    @Published var errorMessage: String?

    private let networkService: NetworkService = NetworkService()
    var isLoading: Bool = false
    
    func getData() {
        self.isLoading = true
        Task {
            do {
                let decodedData = try await networkService.fetchCharacterData()
                DispatchQueue.main.async {
                    if decodedData.info.count == 0 {
                        print("😡 ERROR: No API data")
                    } else {
                        print("👻 Got data")
                        self.count = decodedData.info.count
                        self.pages = decodedData.info.pages
                        self.next = decodedData.info.next
                        self.characters = decodedData.results
                        print("Total Characters: \(self.count)")
                        print("Total Pages: \(self.pages)")
                        print("Next Page URL: \(self.next ?? "")")
                        print("Characters: \(self.characters.count)")
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
}
