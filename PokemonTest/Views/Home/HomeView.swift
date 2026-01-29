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
            .tint(.black)
            .disabled(showMenu)
            .blur(radius: showMenu ? 5 : 0)
            
            if !showMenu {
                VStack {
                    HStack {
                        Button {
                            withAnimation(.spring()) { showMenu.toggle() }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                        .padding(.leading, 10)
                        .padding(.top, 0)
                        Spacer()
                    }
                    Spacer()
                }
            }

            if showMenu {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation { showMenu = false } }
                
                SideMenuView(
                    username: "User",
                    logoutAction: logout,
                    closeMenu: { withAnimation { showMenu = false } }
                )
                .frame(maxWidth: 280)
                .transition(.move(edge: .leading))
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: showMenu)
    }
    
    func logout() { withAnimation { showMenu = false } }
}

#Preview {
    HomeView()
}
