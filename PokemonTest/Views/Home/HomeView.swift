//
//  HomeView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//

import SwiftUI

struct HomeView: View {
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            TabView {
                PokemonView(showMenu: $showMenu)
                    .tabItem {
                        Label("Pokemon", systemImage: "circle.grid.2x2.fill")
                    }
                
                FavoritesView(showMenu: .constant(true))
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
                
                InfoView()
                    .tabItem {
                        Label("Info", systemImage: "info.circle.fill")
                    }
            }
            .tint(.black)
            .disabled(showMenu)
            .blur(radius: showMenu ? 5 : 0)

            
            if showMenu {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation { showMenu = false } }
                
                HStack(spacing: 0) {

                    SideMenuView(
                        logoutAction: logout,
                        closeMenu: { withAnimation { showMenu = false } }
                    )
                    .frame(maxWidth: 280)
                    .transition(.move(edge: .leading))
                    
                    Spacer()
                }
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: showMenu)
    }
    
    func logout() {
        withAnimation {
            showMenu = false
            // Aca borrar session no esta completa
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Entrenador.self, inMemory: true)
}

#Preview {
    HomeView()
}
