//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Fuu on 2021/09/11.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: Pokemon
    
    var body: some View {
        HStack {
            Text("No." + fillId(id: pokemon.id.description))
            Text(pokemon.name)
            Spacer()
        }
    }
}
