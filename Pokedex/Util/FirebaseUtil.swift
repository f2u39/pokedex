//
//  DatabaseUtil.swift
//  Pokedex
//
//  Created by Fuu on 2021/09/23.
//

import Combine
import Firebase
import FirebaseDatabase

final class FirebaseUtil: ObservableObject {
    private var pokemons = [Pokemon]()
    let storage = Storage.storage()

//    func getAllPokemons() -> [Pokemon] {
//        Firestore.firestore().collection("pokemon").getDocuments {
//            (snaps, err) in
//            if err != nil {
//                print("Cannot fetch pokemon list.")
//                return
//            }
//
//            guard let snaps = snaps else { return }
//            for doc in snaps.documents {
//                let poke = Pokemon(dic: doc.data())
//                print(poke.name)
//                self.pokemons.append(poke)
//            }
//        }
//        print(self.pokemons.count)
//        return self.pokemons
//    }
    
    func updatePokemon(p: Pokemon) {
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//
//        guard let key = ref.child("pokemon").childByAutoId().key else { return }
//        let p = ["type1": p.type1,
//                 "type2": p.type2,
//                 "devoId": p.devoId,
//                 "evoId": p.evoId]
//        let childUpdates = ["/pokemon/\(key)": p]
//        ref.updateChildValues(childUpdates)
        
//        let pmRef = ref.child("pokemon").child(p.id)
//        pmRef.updateChildValues([
//            "type1": p.type1,
//            "type2": p.type2,
//            "devoId": p.devoId,
//            "evoId": p.evoId
//        ])
        
        let ref = Firestore.firestore().collection("pokemon").document(p.id)
        ref.updateData([
            "type1": p.type1,
            "type2": p.type2,
            "devoId": p.devoId,
            "evoId": p.evoId
        ]) {
            err in
            if err != nil {
                print(err!)
            }
        }
    }
    
    func getPokemonById(id: String) -> Pokemon? {
        var pokemon: Pokemon? = nil
        
        if id == "" { return pokemon }
        
        Firestore.firestore().collection("pokemon").document(id).getDocument { (snapshot, err) in
            if err != nil {
                print(err!)
                return
            }

            guard let snapshot = snapshot, let data = snapshot.data() else { return }
            let id = data["id"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let type1 = data["type1"] as? String ?? ""
            let type2 = data["type2"] as? String ?? ""
            let devoId = data["devoId"] as? String ?? ""
            let evoId = data["evoId"] as? String ?? ""
            let imgUrl = data["imgUrl"] as? String ?? ""
            pokemon = Pokemon(
                id: id, name: name, type1: type1, type2: type2, devoId: devoId, evoId: evoId, imgUrl: imgUrl)
        }
        return pokemon
    }
    
    func register(id: String, name: String, image: UIImage) {
        // Create a storage reference
        let storageRef = storage.reference().child("images/pokemon").child("\(id).jpg")
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else { return }
        
        // Convert the image into JPEG and compress the quality to reduce its size
        // let data = image.jpegData(compressionQuality: 0.2)
        // if data == nil { return }

        // Create file metadata including the content type
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"

        // Upload the image
        storageRef.putData(uploadImage, metadata: nil, completion: { (metadata, err) in
            if err != nil {
                print("storageRef.putData failed...")
                return
            }
            
            storageRef.downloadURL { (url, err) in
                if err != nil {
                    print("get downloadURL failed...")
                    return
                }
                
                guard let imgUrl = url?.absoluteString else { return }
                let pokeData = [
                    "id": id,
                    "name": name,
                    "type1": "",
                    "type2": "",
                    "devoId": 0,
                    "evoId": 0,
                    "imgUrl": imgUrl] as [String : Any]
                
                // Insert pokemon info
                Firestore.firestore().collection("pokemon").document(id).setData(pokeData) {
                    (err) in
                    if let err = err {
                        print("Firestoreへの保存に失敗しました。\(err)")
                        return
                    }
                }
           }
        })
    }

    func listAllFiles() {
        // Create a reference
        let storageRef = storage.reference().child("images")

        // List all items in the images folder
        storageRef.listAll { (result, error) in
          if let error = error {
            print("Error while listing all files: ", error)
          }

          for item in result.items {
            print("Item in images folder: ", item)
          }
        }
    }

    func listItem() {
        // Create a reference
        let storageRef = storage.reference().child("images")

        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (StorageListResult, Error?) -> Void = { (result, error) in
            if let error = error {
                print("error", error)
            }

            let item = result.items
            print("item: ", item)
        }

        // List the items
        storageRef.list(maxResults: 1, completion: handler)
    }

        // You can use the listItem() function above to get the StorageReference of the item you want to delete
    func deleteItem(item: StorageReference) {
        item.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
}
