//
//  EpisodeVM.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import Foundation

@Observable class EpisodeVM {
    var episodes: [Episode] = []
    var count: Int = 0
    var pages: Int = 0
    var next: String?
    var errorMessage: String?
    var morePages: Bool = true
    
    private var networkService: NetworkService = NetworkService()
    var isLoading: Bool = false
    var allDataLoaded = false
    private var dataURL: String = "https://rickandmortyapi.com/api/episode"
    
    func getData() {
        guard dataURL.hasPrefix("http") else { return }
        self.isLoading = true
        Task {
            do {
                let decodedData = try await networkService.fetchEpisodeData(dataURL: dataURL)
                DispatchQueue.main.async {
                    if decodedData.info.count == 0 {
                        print("😡 ERROR: No API data")
                    } else {
                        print("👻 Got data")
                        self.count = decodedData.info.count
                        self.pages = decodedData.info.pages
                        self.next = decodedData.info.next
                        self.episodes.append(contentsOf: decodedData.results)
                        print("Total Episodes: \(self.count)")
                        print("Total Pages: \(self.pages)")
                        print("Next Page URL: \(self.next ?? "")")
                        print("Episodes: \(self.episodes.count)")
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
            guard dataURL.hasPrefix("http") else {
                allDataLoaded = true
                return
            }
            //            print(dataURL)
            getData()
            await loadAll()
        }
        
    }
}
