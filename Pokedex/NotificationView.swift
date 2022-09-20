//
//  NotificationView.swift
//  Pokedex
//
//  Created by Fuu on 2022/09/19.
//

import SwiftUI

struct NotificationView: View {
    var size: CGSize
    @State var isExpanded: Bool = false
    @State var diPokemon: DiPokemon?
    
    var body: some View {
        if #available(iOS 15.0, *) {
            HStack {
                // any view for notify
//                Text("🇳🇿New Zealand")
//                    .font(.largeTitle)
//                    .frame(width: 200)
//                    .foregroundColor(.purple)
                
//                Text(notification?.title ?? "")
//                    .font(.largeTitle)
                Image(diPokemon?.number ?? "")
                    .resizable()
                    .frame(width: 120, height: 120)
                
                Text(diPokemon?.name ?? "")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            }
            
            .frame(width: isExpanded ? size.width - 22 : 126, height: isExpanded ? 120 : 37.33)
            .blur(radius: isExpanded ? 0 : 30)
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0.5, anchor: .top)
            .background {
                RoundedRectangle(cornerRadius: isExpanded ? 50 : 63, style: .continuous)
                    .fill(.black)
            }
            .clipped()
            .offset(y: 11)
            .onReceive(NotificationCenter.default.publisher(for: .init("NOTIFY"))) { output in
                guard let diPokemon = output.object as? DiPokemon else { return }
                self.diPokemon = diPokemon
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7)) {
                    isExpanded = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7)) {
                            isExpanded = false
                            self.diPokemon = nil
                        }
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
