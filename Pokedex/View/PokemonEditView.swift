//
//  PokemonEditView.swift
//  Pokedex
//
//  Created by Fuu on 2021/09/26.
//

import SwiftUI

struct PokemonEditView: View {
    var pokemon: Pokemon
    
    @State private var type1 = ""
    @State private var type2 = ""
    @State private var evoId = "0"
    @State private var devoId = "0"
    
    var body: some View {
        VStack {
            TextField("Type1", text: $type1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            TextField("Type2", text: $type2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            TextField("↑EvoId", text: $devoId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            TextField("↓DevoId", text: $evoId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            Button(action: {
                // Upload profile image
                let fbUtil = FirebaseUtil()
                fbUtil.updatePokemon(p: Pokemon(
                                        id: pokemon.id,
                                        name: pokemon.name,
                                        type1: self.type1,
                                        type2: self.type2,
                                        devoId: Int(self.devoId) ?? 0,
                                        evoId: Int(self.evoId) ?? 0,
                                        imgUrl: pokemon.imgUrl))
            }) {
                Text("Save")
                    .frame(width: 300)
            }
            .padding()
            .foregroundColor(Color.white)
            .background(Color.green)
            .cornerRadius(20)
        }
    }
}
