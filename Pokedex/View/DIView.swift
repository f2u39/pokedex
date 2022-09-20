//
//  DIView.swift
//  Pokedex
//
//  Created by Fuu on 2022/09/20.
//

import Foundation
import SwiftUI

struct DIView: View {
    var body: some View {
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
        }
    }
    
}
