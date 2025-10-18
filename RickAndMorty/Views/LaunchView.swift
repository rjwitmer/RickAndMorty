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

                }
                .padding()
//                NavigationStack {
//                    Text("Selection:")
//                    NavigationLink {
//                        NavigationStack(root: {
//                            CharactersListView()
//                        })
//                    } label: {
//                        Text("Character List")
//                    }
//                    NavigationLink {
//                        //TODO: Add View
//                    } label: {
//                        Text("Location List")
//                    }
//                    NavigationLink {
//                        //TODO: Add View
//                    } label: {
//                        Text("Episode List")
//                    }
//
//                }
//                .frame(width: 250, height: 250)
//                .padding()
                

                }
            
        }
        .fullScreenCover(isPresented: $characterListPresented, content: {
            NavigationStack {
                CharactersListView()
            }
        })
        .onAppear {
            rickmortyVM.getData()

        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    LaunchView()
}
