//
//  LocationVM.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import Foundation

@Observable class LocationVM {
    var locations: [Location] = []
    var count: Int = 0
    var pages: Int = 0
    var next: String?
    var errorMessage: String?

    private var networkService: NetworkService = NetworkService()
    var isLoading: Bool = false
    var dataURL: String = "https://rickandmortyapi.com/api/location"
    
    func getData() {
        guard dataURL.hasPrefix("http") else { return }
        self.isLoading = true
        Task {
            do {
                let decodedData = try await networkService.fetchLocationData(dataURL: dataURL)
                DispatchQueue.main.async {
                    if decodedData.info.count == 0 {
                        print("😡 ERROR: No API data")
                    } else {
                        print("👻 Got data")
                        self.count = decodedData.info.count
                        self.pages = decodedData.info.pages
                        self.next = decodedData.info.next
                        self.locations.append(contentsOf: decodedData.results)
                        print("Total Locations: \(self.count)")
                        print("Total Pages: \(self.pages)")
                        print("Next Page URL: \(self.next ?? "")")
                        print("Locations: \(self.locations.count)")
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
        guard dataURL.hasPrefix("http") else { return }
        getData()
    }
    
    func loadAll() async {
        Task {
            try await Task.sleep(nanoseconds: 500_000_000)
            guard dataURL.hasPrefix("http") else { return }
//            print(dataURL)
            getData()
            await loadAll()
        }
        
    }
}
