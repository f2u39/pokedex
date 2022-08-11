//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Fuu on 2021/09/29.
//

import Foundation
import Firebase

class PokemonDetailViewModel: ObservableObject {
    private let pokemon: Pokemon
    
    @Published var evolution: Pokemon? = nil
    @Published var devolution: Pokemon? = nil
    @Published var initial: Pokemon? = nil
    @Published var final: Pokemon? = nil
    
    // @Published var currentPokemon: Pokemon
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("pokemon").document(pokemon.evoId).getDocument { (snap, error) in
            if let error = error {
                fatalError("\(error)")
            }
            guard let data = snap?.data() else { return }
            let id = data["id"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let type1 = data["type1"] as? String ?? ""
            let type2 = data["type2"] as? String ?? ""
            let devoId = data["devoId"] as? String ?? ""
            let evoId = data["evoId"] as? String ?? ""
            let imgUrl = data["imgUrl"] as? String ?? ""
            self.evolution = Pokemon(id: id, name: name, type1: type1, type2: type2, devoId: devoId, evoId: evoId, imgUrl: imgUrl)
        }

        db.collection("pokemon").document(pokemon.devoId).getDocument { (snap, error) in
            if let error = error {
                fatalError("\(error)")
            }
            guard let data = snap?.data() else { return }
            let id = data["id"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let type1 = data["type1"] as? String ?? ""
            let type2 = data["type2"] as? String ?? ""
            let devoId = data["devoId"] as? String ?? ""
            let evoId = data["evoId"] as? String ?? ""
            let imgUrl = data["imgUrl"] as? String ?? ""
            self.devolution = Pokemon(id: id, name: name, type1: type1, type2: type2, devoId: devoId, evoId: evoId, imgUrl: imgUrl)
        }
        
        db.collection("pokemon").document(evolution?.evoId ?? "0").getDocument { (snap, error) in
            if let error = error {
                fatalError("\(error)")
            }
            guard let data = snap?.data() else { return }
            let id = data["id"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let type1 = data["type1"] as? String ?? ""
            let type2 = data["type2"] as? String ?? ""
            let devoId = data["devoId"] as? String ?? ""
            let evoId = data["evoId"] as? String ?? ""
            let imgUrl = data["imgUrl"] as? String ?? ""
            self.final = Pokemon(id: id, name: name, type1: type1, type2: type2, devoId: devoId, evoId: evoId, imgUrl: imgUrl)
        }

        db.collection("pokemon").document(devolution?.devoId ?? "0").getDocument { (snap, error) in
            if let error = error {
                fatalError("\(error)")
            }
            guard let data = snap?.data() else { return }
            let id = data["id"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let type1 = data["type1"] as? String ?? ""
            let type2 = data["type2"] as? String ?? ""
            let devoId = data["devoId"] as? String ?? ""
            let evoId = data["evoId"] as? String ?? ""
            let imgUrl = data["imgUrl"] as? String ?? ""
            self.initial = Pokemon(id: id, name: name, type1: type1, type2: type2, devoId: devoId, evoId: evoId, imgUrl: imgUrl)
        }
    }
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
