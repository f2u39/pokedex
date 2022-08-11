//
//  PokemonApi.swift
//  Pokedex
//
//  Created by Fuu on 2021/10/03.
//

import Foundation

struct Chain: Codable {
    var species: Species
}

struct Species: Codable {
    var name: String
    var url: String
}
