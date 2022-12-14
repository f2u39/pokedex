//
//  DynamicIslandExampleApp.swift
//  Pokedex
//
//  Created by Fuu on 2022/09/19.
//

import Foundation
import SwiftUI

//@main
struct MainApp: App {
    
    @StateObject var viewModel = PokemonViewModel()
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 15.0, *) {
                ContentView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .top) {
                        GeometryReader { proxy in
                            let size = proxy.size
                            NotificationView(size: size)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        }
                        .ignoresSafeArea()
                    }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct DiPokemon {
    var number: String
    var name: String
}
