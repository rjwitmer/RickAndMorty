//
//  LocationDetailView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-24.
//

import SwiftUI

struct LocationDetailView: View {
    @Environment(CharacterVM.self) var characterVM
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
            
            VStack {

                Grid(alignment: .leading) {
                    GridRow(alignment: .firstTextBaseline) {
                        Spacer()
                        Text("Character:")
                            .bold()
                        Divider()
                        Text("Gender:")
                            .bold()
                        Divider()
                        Text("Status:")
                            .bold()
                        Spacer()
                    }
                }
                    
                List(generateCharacterList(characters: characterVM.characters, characterURL: location.residents )) { character in
                    HStack {
                        Grid(alignment: .leading) {
                            GridRow(alignment: .firstTextBaseline) {
                                Text(character.name)
                                Divider()
                                Text(character.gender)
                                Divider()
                                Text(character.status)
                                Spacer()
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
    // Return a filtered array of Episodes based on the id extracted from the character.episodes array of strings
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
//    LocationDetailView(location: Location(id: 999,
//                                          name: "My Location",
//                                          type: "Planet",
//                                          dimension: "My Dimension",
//                                          residents: ["Bob","Dante"],
//                                          url: "https://rickandmortyapi.com/api/location/1"))
//}
