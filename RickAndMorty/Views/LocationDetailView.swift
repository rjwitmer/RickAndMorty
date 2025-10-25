//
//  LocationDetailView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-24.
//

import SwiftUI

struct LocationDetailView: View {
    let location: Location
    var body: some View {
        VStack {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.black)
            Grid(alignment: .leading) {
                Divider()
                GridRow(alignment: .firstTextBaseline) {
                    Text("Type:")
                        .bold()
                    Text(location.type)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Dimension:")
                        .bold()
                    Text(location.dimension)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Residents:")
                        .bold()
                    Text("\(location.residents.count)")
                }
            }
            .font(.title2)
            .frame(width: 500)
        Spacer()
        }
    }
}

#Preview {
    LocationDetailView(location: Location(id: 999,
                                          name: "My Location",
                                          type: "Planet",
                                          dimension: "My Dimension",
                                          residents: ["Bob","Dante"],
                                          url: "https://rickandmortyapi.com/api/location/1"))
}
