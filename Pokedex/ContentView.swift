//
//  LiveActivityAttributes.swift
//  Pokedex
//
//  Created by Fuu on 2022/09/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Bulbasaur🌱") {
                NotificationCenter.default.post(
                    name: .init("NOTIFY"),
                    object: DiPokemon(
                        number: "001",
                        name: "フシギダネ"))
            }
            Button("Ivysaur🌷") {
                NotificationCenter.default.post(
                    name: .init("NOTIFY"),
                    object: DiPokemon(
                        number: "002",
                        name: "フシギソウ"))
            }
            Button("Venusaur🌺") {
                NotificationCenter.default.post(
                    name: .init("NOTIFY"),
                    object: DiPokemon(
                        number: "003",
                        name: "フシギバナ"))
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
