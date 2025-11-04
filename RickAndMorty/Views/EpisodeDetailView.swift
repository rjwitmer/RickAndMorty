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
//                GridRow(alignment: .firstTextBaseline) {
//                    Text("Characters:")
//                        .bold()
//                    Text("\(episode.characters.count)")
//                }
            }
            .font(.title2)
            .frame(width: 500)

            ScrollView {
                LazyVGrid(
                    columns: [
//                        GridItem(.fixed(600)),
                        GridItem(.flexible(minimum: 50, maximum: .infinity)),
                        GridItem(.flexible(minimum: 50, maximum: .infinity)),
                        GridItem(.flexible(minimum: 50, maximum: .infinity)),
                        GridItem(.flexible(minimum: 50, maximum: .infinity)),
                        GridItem(.flexible(minimum: 50, maximum: .infinity)),
                        GridItem(.flexible(minimum: 50, maximum: .infinity))
                    ],
                    alignment: .leading,
                    spacing: 10
                ) {
                    // Column Headers
                    Group {
                        Text("Character:")
                        Text("Gender:")
                        Text("Species:")
                        Text("Type:")
                        Text("Status:")
                        Text("Location:")
                    }
                    .bold()
                    .foregroundStyle(.blue)
    
                    // List the Character data
                    ForEach(generateCharacterList(characters: characterVM.characters, characterURL: episode.characters )) { character in
                        /*@START_MENU_TOKEN@*/Text(character.name)/*@END_MENU_TOKEN@*/
                        Text(character.gender)
                        Text(character.species)
                        Text(character.type)
                        Text(character.status)
                        Text(character.location.name)
                    }
                }
            }
            .padding()
            Text("There are: \(episode.characters.count) characters in this location.")
        }
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
