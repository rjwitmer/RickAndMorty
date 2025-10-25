//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-24.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode
    var body: some View {
        VStack {
            Text(episode.name)
                .font(.largeTitle)
                .fontWeight(.black)
            Grid(alignment: .leading) {
                Divider()
                GridRow(alignment: .firstTextBaseline) {
                    Text("Air Date:")
                        .bold()
                    Text(episode.air_date)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Episode:")
                        .bold()
                    Text(episode.episode)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Characters:")
                        .bold()
                    Text("\(episode.characters.count)")
                }
            }
            .font(.title2)
            .frame(width: 500)
        Spacer()
        }
    }
}

#Preview {
    EpisodeDetailView(episode: Episode(id: 999, name: "My Episode",
                                       air_date: "Today",
                                       episode: "Place Holder",
                                       characters: ["Bob","Dante"],
                                       url: "https://rickandmortyapi.com/api/episode/1"))
}
