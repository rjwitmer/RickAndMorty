//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-17.
//

import SwiftUI

struct CharactersListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CharacterVM.self) var characterVM
    @Environment(EpisodeVM.self) var episodeVM

//    @State var characterVM: CharacterVM
    @State private var searchText: String = ""
    
    var body: some View {
        
            NavigationStack {
                ZStack {
                    List(searchResults) { character in
                        VStack {
                            
                            NavigationLink {
                                CharacterDetailView(character: character)
                                    .environment(episodeVM)
                            } label: {
                                Text(character.name)
                                    .font(.title2)
                            }
                            
                            Spacer()
                        }
                        //                    .task {   // Allows lazy loading of the next page during scrolling, but doesn't function well with this API
                        //                        await personsVM.getNextPage()
                        //                    }
                    }
                    .listStyle(.automatic)
                    .navigationTitle(Text("Characters:"))
                    .toolbar {
                        ToolbarItem(placement: .status) {
                            Text("Titles: \(searchResults.count) of \(characterVM.count)")
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                dismiss()
                            } label: {
                                Text("Cancel")
                            }

                        }
//                        ToolbarItem(placement: .bottomBar) {
//                            Button("Load All") {
//                                Task {
//                                    await characterVM.loadAll()
//                                }
//                            }
//                            
//                        }
//                        ToolbarItem(placement: .bottomBar) {
//                            Button("Next Page") {
//                                Task {
//                                    await characterVM.loadNextPage()
//                                }
//                            }
//                        }
                    }
                    .searchable(text: $searchText)
                    
                    if characterVM.isLoading {
                        ProgressView()
                            .tint(.red)
                            .scaleEffect(4.0)
                    }
                }
//                .task {
//                    characterVM.getData()
//                    print("Data Loaded --> Count: \(characterVM.count)")
//                }
            }
            .padding()

            
            
            var searchResults: [RMCharacter] {
                if searchText.isEmpty {
                    return characterVM.characters
                } else {    // There is searchText data
                    return characterVM.characters.filter {
                        $0.name.lowercased().contains(searchText.lowercased())
                    }
                }
            }
        }
    
}

// Disable the preview because data is passed from LaunchView
//#Preview {
//    CharactersListView()
//}
