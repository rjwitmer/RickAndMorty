//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Bob Witmer on 2025-10-24.
//

import SwiftUI

struct CharacterDetailView: View {

        @Environment(EpisodeVM.self) var episodeVM
    // Create a temporary episodes array for testing
//    var episodes: [Episode] = [Episode(id: 1, name: "Episode 1", air_date: "Air Date", episode: "https://rickandmortyapi.com/api/episode/1", characters: ["1", "2"], url: "url"),
//    Episode(id: 2, name: "Name 2", air_date: "2nd Air Date", episode: "https://rickandmortyapi.com/api/episode/2", characters: ["3"], url: "url2")]
    let character: RMCharacter
    @State private var episodeListPresented: Bool = false
    let columns = [
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.flexible(), alignment: .topLeading)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.largeTitle)
                .fontWeight(.black)
            HStack {
            
                characterImage
                
                
                Grid(alignment: .leading) {
                    Divider()
                    GridRow(alignment: .firstTextBaseline) {
                        Text("Status:")
                            .bold()
                        Text(character.status)
                    }
                    GridRow(alignment: .firstTextBaseline) {
                        Text("Species:")
                            .bold()
                        Text(character.species)
                    }
                    GridRow(alignment: .firstTextBaseline) {
                        Text("Type:")
                            .bold()
                        Text(character.type)
                    }
                    GridRow(alignment: .firstTextBaseline) {
                        Text("Gender:")
                            .bold()
                        Text(character.gender)
                    }
                    GridRow(alignment: .firstTextBaseline) {
                        Text("Origin:")
                            .bold()
                        Text(character.origin.name)
                    }
                    GridRow(alignment: .firstTextBaseline) {
                        Text("Location:")
                            .bold()
                        Text(character.location.name)
                    }
                    GridRow(alignment: .firstTextBaseline) {
                        Text("Episodes:")
                            .bold()
                        Text("\(character.episode.count)")
                    }
                }
                .font(.title2)
                .frame(width: 500)
            }
            .padding(.horizontal)
            
            VStack {

                Grid(alignment: .leading) {
                    GridRow(alignment: .firstTextBaseline) {
                        Spacer()
                        Text("Episode:")
                            .bold()
                        Spacer()
                        Spacer()
                        Text("Air Date:")
                            .bold()
                        Spacer()
                    }
                }
                    
                List(generateEpisodeList(episodes: episodeVM.episodes, characterEpisodes: character.episode)) { episode in
                    HStack {
                        Grid(alignment: .leading) {
                            GridRow(alignment: .firstTextBaseline) {
                                Text(episode.name)
                                Spacer()
                                Text(episode.air_date)
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

    }
}

extension CharacterDetailView {
    var characterImage: some View {
        AsyncImage(url: URL(string: character.image)) { phase in
            if let image = phase.image {    // We have a valid image
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    }
                
            } else if phase.error != nil {  // We've had an error, load a empty image
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    }
            } else {    // Use a placeholder - image loading
                //                        RoundedRectangle(cornerRadius: 10)
                //                            .foregroundStyle(.clear)
                ProgressView()
                    .tint(Color.red)
                    .scaleEffect(4.0)
            }
        }
        .frame(width: 300, height: 300)
//        .padding(.trailing)
        
    }

    // Return a filtered array of Episodes based on the id extracted from the character.episodes array of strings
    func generateEpisodeList(episodes: [Episode], characterEpisodes: [String]) -> [Episode] {
        // Extract the Episode id and place in an array
        var idList: [Int] = []
        var filteredEpisodes: [Episode] = []
        if !characterEpisodes.isEmpty {
            characterEpisodes.forEach { mySuffix in
                if let myRange = mySuffix.range(of: "/episode/") {
                    let myIndex = mySuffix.index(mySuffix.endIndex, offsetBy: mySuffix.distance(from: mySuffix.endIndex, to: myRange.upperBound))
                            idList.append(Int(mySuffix.suffix(from: myIndex)) ?? -1)
                }
            }
        }
//        print(idList)
        // Iterate through the idList and build a new array based on matching id
        idList.forEach { id in
            filteredEpisodes.append(contentsOf: episodes.filter( {$0.id == id} ))
        //    filteredArray.append(contentsOf: myArray.filter{ $0.contains(String(id))})
        }
//        print(String(filteredEpisodes.count))

        return filteredEpisodes
    }
}

//#Preview {
//    CharacterDetailView(character: RMCharacter(id: 5000,
//                                               name: "Joe Blow",
//                                               status: "Alive",
//                                               species: "Human",
//                                               type: "",
//                                               gender: "Male",
//                                               origin: Origin(name: "Earth"),
//                                               location: CharacterLocation(name: "Toronto"),
//                                               image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
//                                               episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/6"]
//                                              )
//    )
//}
