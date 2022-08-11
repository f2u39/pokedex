//
//  PokemonApiView.swift
//  Pokedex
//
//  Created by Fuu on 2021/10/03.
//

import SwiftUI

struct PokemonApiView: View {
    @State private var species = [Species]()
    
    var body: some View {
        NavigationView {
            List(species, id: \.name) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.url)
                }
            }.navigationTitle("Pokemon")
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/evolution-chain/1") else {
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let decoder = JSONDecoder()
                guard let decodedChain = try? decoder.decode(Chain.self, from: data) else {
                    print("Decode Json error.")
                    return
                }
 
                DispatchQueue.main.async {
                    // species.append(decodedChain)
                    // species = decodedChain.species
                    species.append(decodedChain.species)
                }
 
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}

struct PokemonApiView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonApiView()
    }
}
