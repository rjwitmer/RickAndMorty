//
//  EpisodeVM.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import Foundation
internal import Combine

class EpisodeVM: ObservableObject {
    @Published var episodes: [Episode] = []
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
                let decodedData = try await networkService.fetchEpisodeData()
                DispatchQueue.main.async {
                    if decodedData.info.count == 0 {
                        print("😡 ERROR: No API data")
                    } else {
                        print("👻 Got data")
                        self.count = decodedData.info.count
                        self.pages = decodedData.info.pages
                        self.next = decodedData.info.next
                        self.episodes.append(contentsOf: decodedData.results)
                        print("Total Characters: \(self.count)")
                        print("Total Pages: \(self.pages)")
                        print("Next Page URL: \(self.next ?? "")")
                        print("Characters: \(self.episodes.count)")
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
    func loadNextPage(episode: Episode) async {
        guard let lastEpisode = episodes.last else { return }
        if episode.id == lastEpisode.id && networkService.episodesURL.hasPrefix("http") {
            getData()
        }
    }
    
    func loadAll() async {
        Task { @MainActor in
            guard networkService.episodesURL.hasPrefix("http") else { return }
            
            getData()     // get nextpage of data
            await loadAll()    // Recursive call until there are no more pages to load 'next = null'
        }
        
    }
}
