//
//  EpisodesListView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import SwiftUI

struct EpisodesListView: View {
    @Environment(\.dismiss) var dismiss
    @State var episodeVM: EpisodeVM
    @State private var searchText: String = ""
    
    var body: some View {

        
            NavigationStack {
                ZStack {
                    List(searchResults) { episode in
                        VStack {
                            
                            NavigationLink {
                                EpisodeDetailView(episode: episode)
                            } label: {
                                Text(episode.name)
                                    .font(.title2)
                            }
                            
                            Spacer()
                        }
                        //                    .task {   // Allows lazy loading of the next page during scrolling, but doesn't function well with this API
                        //                        await personsVM.getNextPage()
                        //                    }
                    }
                    .listStyle(.automatic)
                    .navigationTitle(Text("Episodes:"))
                    .toolbar {
                        ToolbarItem(placement: .status) {
                            Text("Titles: \(searchResults.count) of \(episodeVM.count)")
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                dismiss()
                            } label: {
                                Text("Cancel")
                            }

                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button("Load All") {
                                Task {
                                    await episodeVM.loadAll()
                                }
                            }
                            
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button("Next Page") {
                                Task {
//                                    await episodeVM.getNextPage()
                                }
                            }
                        }
                    }
                    .searchable(text: $searchText)
                    
                    if episodeVM.isLoading {
                        ProgressView()
                            .tint(.red)
                            .scaleEffect(4.0)
                    }
                }
                .onAppear {
                    episodeVM.getData()
                    print("Data Loaded --> Count: \(episodeVM.count)")
                }
            }
            .padding()

            
            
            var searchResults: [Episode] {
                if searchText.isEmpty {
                    return episodeVM.episodes
                } else {    // There is searchText data
                    return episodeVM.episodes.filter {
                        $0.name.lowercased().contains(searchText.lowercased())
                    }
                }
            }
        }
    
}

#Preview {
    EpisodesListView(episodeVM: EpisodeVM())
}
