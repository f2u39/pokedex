//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Fuu on 2021/09/11.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: Pokemon
    @ObservedObject var viewModel: PokemonDetailViewModel
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.viewModel = PokemonDetailViewModel(pokemon: pokemon)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                HStack {
                    Text(pokemon.name)
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    if !pokemon.type1.isEmpty {
                        Image(pokemon.type1)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    if !pokemon.type2.isEmpty {
                        Image(pokemon.type2)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                
                AsyncImage(url: URL(string: pokemon.imgUrl)!,
                           placeholder: { Text("Loading...") },
                           image: { Image(uiImage: $0).resizable() })
                    .frame(width: 260, height: 260)
                    .border(Color.gray, width: 3)
                
//                let fbUtil = FirebaseUtil()
//                let devo: Pokemon? = fbUtil.getPokemonById(id: pokemon.devoId)
//                let evo: Pokemon? = fbUtil.getPokemonById(id: pokemon.evoId)
//
//                let idevo: Pokemon? = fbUtil.getPokemonById(id: devo?.devoId ?? "")
//                let fevo: Pokemon? = fbUtil.getPokemonById(id: evo?.evoId ?? "")

                VStack(alignment: .center) {
                    Image("evolution")
                        .resizable()
                    HStack {
                        if viewModel.initial != nil {
                            VStack(alignment: .center) {
                                AsyncImage(url: URL(string: viewModel.initial!.imgUrl)!,
                                           placeholder: { Text("Loading...") },
                                           image: { Image(uiImage: $0).resizable() })
                                    .frame(width: 100, height: 100)
                                    .border(Color.blue, width: 1)
                                Text(viewModel.initial!.name)
                            }
                        }

                        if viewModel.devolution != nil {
                            VStack(alignment: .center) {
                                AsyncImage(url: URL(string: viewModel.devolution!.imgUrl)!,
                                           placeholder: { Text("Loading...") },
                                           image: { Image(uiImage: $0).resizable() })
                                    .frame(width: 100, height: 100)
                                    .border(Color.blue, width: 1)
                                Text(viewModel.devolution!.name)
                            }
                        }

                        VStack(alignment: .center) {
                            AsyncImage(url: URL(string: pokemon.imgUrl)!,
                                       placeholder: { Text("Loading...") },
                                       image: { Image(uiImage: $0).resizable() })
                                .frame(width: 100, height: 100)
                                .border(Color.blue, width: 1)
                            Text(pokemon.name)
                        }

                        if viewModel.evolution != nil {
                            VStack(alignment: .center) {
                                AsyncImage(url: URL(string: viewModel.evolution!.imgUrl)!,
                                           placeholder: { Text("Loading...") },
                                           image: { Image(uiImage: $0).resizable() })
                                    .frame(width: 100, height: 100)
                                    .border(Color.blue, width: 1)
                                Text(viewModel.evolution!.name)
                            }
                        }

                        if viewModel.final != nil {
                            VStack(alignment: .center) {
                                AsyncImage(url: URL(string: viewModel.evolution!.imgUrl)!,
                                           placeholder: { Text("Loading...") },
                                           image: { Image(uiImage: $0).resizable() })
                                    .frame(width: 100, height: 100)
                                    .border(Color.blue, width: 1)
                                Text(viewModel.final!.name)
                            }
                        }
                    }
                }
            }
            .onAppear(perform: viewModel.fetchData)
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: PokemonEditView(pokemon: pokemon)) {
                            Text("Edit")
                        }
                    }
                }
            }
        }
    }
}
