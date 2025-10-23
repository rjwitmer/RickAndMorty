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
    @State var rickmortyVM: RickMortyVM = RickMortyVM()
    @State var characterListPresented: Bool = false
    @State var locationListPresented: Bool = false
    @State var episodeListPresented: Bool = false
    var body: some View {
        ZStack {
            
            Image("rickmorty")
                .resizable()
                .scaledToFit()

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
                .padding()              

                }
            
        }
        .fullScreenCover(isPresented: $characterListPresented) {
            NavigationStack {
                CharactersListView()
            }
        }
        .fullScreenCover(isPresented: $episodeListPresented) {
            NavigationStack {
                EpisodesListView()
            }
        }
        .fullScreenCover(isPresented: $locationListPresented) {
            NavigationStack {
                LocationsListView()
            }
        }
        .onAppear {
            rickmortyVM.getData()

        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    LaunchView()
}
