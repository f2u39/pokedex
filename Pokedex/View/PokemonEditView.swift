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
    @State private var evoId = ""
    @State private var devoId = ""
    
    var body: some View {
        VStack {
            TextField("タイプ1(半角英字)", text: $type1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            TextField("タイプ2(半角英字)", text: $type2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            TextField("↑ポケモンID(半角数字)", text: $devoId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            TextField("↓ポケモンID(半角数字)", text: $evoId)
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
                                        devoId: self.devoId,
                                        evoId: self.evoId,
                                        imgUrl: pokemon.imgUrl))
            }) {
                Text("保存")
                    .frame(width: 300)
            }
            .padding()
            .foregroundColor(Color.white)
            .background(Color.green)
            .cornerRadius(20)
        }
    }
}
