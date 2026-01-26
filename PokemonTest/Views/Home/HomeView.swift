//
//  HomeView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.yellow
            TabView {
                PokemonView()
                    .tabItem {
     
                        Label("Pokemon", systemImage: "circle.grid.2x2.fill")
                    }

                FavoritesView()
                    .tabItem {
        
                        Label("Favorites", systemImage: "star.fill")
                    }

                InfoView()
                    .tabItem {

                        Label("Info", systemImage: "info.circle.fill")
                    }
            }
            .accentColor(.black)
            }
       
        }
       
}

#Preview {
    HomeView()
}
