//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-24.
//

import SwiftUI

struct EpisodeDetailView: View {
    @Environment(CharacterVM.self) var characterVM
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
            VStack {

                Grid(horizontalSpacing: 30, verticalSpacing: 30) {
                    GridRow(alignment: .firstTextBaseline) {
                        Text("Character:")
                            .bold()
                            .gridCellColumns(3)
                        Text("Gender:")
                            .bold()
                        Text("Status:")
                            .bold()
                    }
                }
                .frame(width: 600)
                    
                List(generateCharacterList(characters: characterVM.characters, characterURL: episode.characters )) { character in
                    HStack {
                        Grid(horizontalSpacing: 30, verticalSpacing: 10) {
                            GridRow(alignment: .firstTextBaseline) {
                                Text(character.name)
                                    .gridCellColumns(3)
                                Text(character.gender)
                                Text(character.status)
                            }
                        }
                        .font(.default)
                    }
                }
                
//                List(character.episode, id: \.self) { episode in
//                    Text(episode.description)
//                }
                
            }
            .frame(width: 600)
            Spacer()
        }
        Spacer()
    }
    func generateCharacterList(characters: [RMCharacter], characterURL: [String]) -> [RMCharacter] {
        // Extract the Character id and place in an array
        var idList: [Int] = []
        var filteredCharacters: [RMCharacter] = []
        if !characterURL.isEmpty {
            characterURL.forEach { mySuffix in
                if let myRange = mySuffix.range(of: "/character/") {
                    let myIndex = mySuffix.index(mySuffix.endIndex, offsetBy: mySuffix.distance(from: mySuffix.endIndex, to: myRange.upperBound))
                            idList.append(Int(mySuffix.suffix(from: myIndex)) ?? -1)
                }
            }
        }
//        print(idList)
        // Iterate through the idList and build a new array based on matching id
        idList.forEach { id in
            filteredCharacters.append(contentsOf: characters.filter( {$0.id == id} ))
        //    filteredArray.append(contentsOf: myArray.filter{ $0.contains(String(id))})
        }
//        print(String(filteredEpisodes.count))

        return filteredCharacters
    }
}

//#Preview {
//    EpisodeDetailView(episode: Episode(id: 999, name: "My Episode",
//                                       air_date: "Today",
//                                       episode: "Place Holder",
//                                       characters: ["Bob","Dante"],
//                                       url: "https://rickandmortyapi.com/api/episode/1"))
//}
