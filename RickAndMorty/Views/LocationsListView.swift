//
//  LocationsListView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-23.
//

import SwiftUI

struct LocationsListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(LocationVM.self) var locationVM
//    @State var locationVM: LocationVM
    @State private var searchText: String = ""
    
    var body: some View {

            NavigationStack {
                ZStack {
                    List(searchResults) { location in
                        VStack {
                            
                            NavigationLink {
                                LocationDetailView(location: location)
                                //                                DetailView(person: person)
                            } label: {
                                Text(location.name)
                                    .font(.title2)
                            }
                            
                            Spacer()
                        }
                        //                    .task {   // Allows lazy loading of the next page during scrolling, but doesn't function well with this API
                        //                        await personsVM.getNextPage()
                        //                    }
                    }
                    .listStyle(.automatic)
                    .navigationTitle(Text("Locations:"))
                    .toolbar {
                        ToolbarItem(placement: .status) {
                            Text("Titles: \(searchResults.count) of \(locationVM.count)")
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
//                                    await locationVM.loadAll()
//                                }
//                            }
//                            
//                        }
//                        ToolbarItem(placement: .bottomBar) {
//                            Button("Next Page") {
//                                Task {
//                                    await locationVM.loadNextPage()
//                                }
//                            }
//                        }
                    }
                    .searchable(text: $searchText)
                    
                    if locationVM.isLoading {
                        ProgressView()
                            .tint(.red)
                            .scaleEffect(4.0)
                    }
                }
                .task {
                    locationVM.getData()
                    print("Data Loaded --> Count: \(locationVM.count)")
                }
            }
            .padding()

            
            
            var searchResults: [Location] {
                if searchText.isEmpty {
                    return locationVM.locations
                } else {    // There is searchText data
                    return locationVM.locations.filter {
                        $0.name.lowercased().contains(searchText.lowercased())
                    }
                }
            }
        }
    
}

// Disabled Preview because locationVM is in Environment
//#Preview {
//    LocationsListView()
//}
