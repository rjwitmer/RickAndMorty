//
//  LaunchView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-16.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct LaunchView: View {
    @State private var rickmortyVM: RickMortyVM = RickMortyVM()
    @State private var characterVM: CharacterVM = CharacterVM()
    @State private var locationVM: LocationVM = LocationVM()
    @State private var episodeVM: EpisodeVM = EpisodeVM()
    @State private var characterListPresented: Bool = false
    @State private var locationListPresented: Bool = false
    @State private var episodeListPresented: Bool = false

    var body: some View {
        ZStack {
            
            Image("rickmorty")
                .resizable()
                .scaledToFit()
            
            if characterVM.allDataLoaded && episodeVM.allDataLoaded && locationVM.allDataLoaded {
                HStack(spacing: 200) {
                    Spacer()
                    VStack {
                        Text("Selection:")
                        Button {
                            characterListPresented.toggle()
                        } label: {
                            Text("Character List")
                        }
                        Button {
                            episodeListPresented.toggle()
                        } label: {
                            Text("Episode List")
                        }
                        Button {
                            locationListPresented.toggle()
                        } label: {
                            Text("Location List")
                        }
                    }
                    .padding()}
                
            }
            if !characterVM.allDataLoaded || !episodeVM.allDataLoaded || !locationVM.allDataLoaded {
                HStack {
                    Spacer()
                    ProgressView()
                        .tint(Color.red)
                        .scaleEffect(1.0)
                    
                    VStack(alignment: .leading) {
                        if !characterVM.allDataLoaded {
                            Text("Loading Character Data...")
                        }
                        if !episodeVM.allDataLoaded {
                            Text("Loading Episode Data...")
                        }
                        if !locationVM.allDataLoaded {
                            Text("Loading Location Data...")
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $characterListPresented) {
            NavigationStack {
                CharactersListView()
                    .environment(characterVM)
                    .environment(episodeVM)
            }
        }
        .fullScreenCover(isPresented: $episodeListPresented) {
            NavigationStack {
                EpisodesListView()
                    .environment(episodeVM)
                    .environment(characterVM)
            }
        }
        .fullScreenCover(isPresented: $locationListPresented) {
            NavigationStack {
                LocationsListView()
                    .environment(locationVM)
                    .environment(characterVM)
            }

        }
        .onAppear {
            rickmortyVM.getData()
            Task {
//                characterVM.getData()
//                characterVM.allDataLoaded = true    // Tempory load of one page of data to not overload the API
                await characterVM.loadAll()
                
            }
            Task {
//                episodeVM.getData()
//                episodeVM.allDataLoaded = true
                await episodeVM.loadAll()

            }
            Task {
//                locationVM.getData()
//                locationVM.allDataLoaded = true
                await locationVM.loadAll()
            }
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    LaunchView()
}
