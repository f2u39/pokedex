//
//  PokemonList.swift
//  Pokedex
//
//  Created by Fuu on 2021/09/11.
//

import SwiftUI
import Firebase

struct PokemonListView: View {
    @StateObject var viewModel = PokemonViewModel()
    // @State var pokemons = [Pokemon]()
    
    var body: some View {
        NavigationView {
            List(viewModel.pokemons, id: \.id) { poke in
                NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                    PokemonRow(pokemon: poke)
                }
            }
            .onAppear() {
                self.viewModel.fetchData()
            }
            .navigationBarTitle("ポケモン", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: PokemonRegisterView()) {
                            Text("Register")
                        }
                    }
                }
            }
        }
    }
}
