//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Fuu on 2021/09/26.
//

import Foundation
import Firebase

class PokemonViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    // @Published var currentPokemon: Pokemon
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("pokemon").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }

          self.pokemons = documents.map { queryDocumentSnapshot -> Pokemon in
            let data = queryDocumentSnapshot.data()
            let id = data["id"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let type1 = data["type1"] as? String ?? ""
            let type2 = data["type2"] as? String ?? ""
            let devoId = data["devoId"] as? String ?? ""
            let evoId = data["evoId"] as? String ?? ""
            let imgUrl = data["imgUrl"] as? String ?? ""

            return Pokemon(
                id: id, name: name, type1: type1, type2: type2, devoId: devoId, evoId: evoId, imgUrl: imgUrl)
          }
        }
    }
}
