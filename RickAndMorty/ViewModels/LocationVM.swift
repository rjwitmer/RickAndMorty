//
//  LocationVM.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import Foundation
internal import Combine

class LocationVM: ObservableObject {
    @Published var locations: [Location] = []
    @Published var count: Int = 0
    @Published var pages: Int = 0
    @Published var next: String?
    @Published var errorMessage: String?
    @Published var morePages: Bool = true

    var networkService: NetworkService = NetworkService()
    var isLoading: Bool = false
    
    func getData() {
        self.isLoading = true
        Task {
            do {
                let decodedData = try await networkService.fetchLocationData()
                DispatchQueue.main.async {
                    if decodedData.info.count == 0 {
                        print("😡 ERROR: No API data")
                    } else {
                        print("👻 Got data")
                        self.count = decodedData.info.count
                        self.pages = decodedData.info.pages
                        self.next = decodedData.info.next
                        self.locations.append(contentsOf: decodedData.results)
                        print("Total Characters: \(self.count)")
                        print("Total Pages: \(self.pages)")
                        print("Next Page URL: \(self.next ?? "")")
                        print("Characters: \(self.locations.count)")
                        self.networkService.charactersURL = self.next ?? ""
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
    func loadNextPage(location: Location) async {
        guard let lastLocation = locations.last else { return }
        if location.id == lastLocation.id && networkService.locationsURL.hasPrefix("http") {
            getData()
        }
    }
    
    func loadAll() async {
        Task { @MainActor in
            guard networkService.locationsURL.hasPrefix("http") else { return }
            
            getData()     // get nextpage of data
            await loadAll()    // Recursive call until there are no more pages to load 'next = null'
        }
        
    }
}
