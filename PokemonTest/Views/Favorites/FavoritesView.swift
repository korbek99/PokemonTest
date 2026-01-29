//
//  FavoritesView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//

import SwiftUI
import SwiftUI

struct FavoritePokemon: Identifiable {
    let id: Int
    let name: String
    var formattedID: String { String(format: "%03d", id) }
}

struct FavoritesView: View {
 
    @State private var searchText = ""
    @Binding var showMenu: Bool
    private let favoritePokemons = [
        FavoritePokemon(id: 1, name: "bulbasaur"),
        FavoritePokemon(id: 4, name: "charmander"),
        FavoritePokemon(id: 7, name: "squirtle"),
        FavoritePokemon(id: 25, name: "pikachu"),
        FavoritePokemon(id: 133, name: "eevee")
    ]
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var filteredPokemon: [FavoritePokemon] {
        if searchText.isEmpty {
            return favoritePokemons
        } else {
            return favoritePokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow.opacity(0.15)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(filteredPokemon) { pokemon in
                            FavoriteGridItem(pokemon: pokemon)
                        }
                    }
                    .padding()
                }
                .overlay {
                    if filteredPokemon.isEmpty {
                        ContentUnavailableView("No hay favoritos",
                                             systemImage: "heart.slash",
                                             description: Text("Tus Pokémon marcados aparecerán aquí."))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "circle.grid.2x2.fill")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.red)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.1), radius: 3)
                            )
                    }
                }

                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                        Text("Favoritos")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Buscar en mis favoritos...")
            .toolbarBackground(Color.yellow, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

// MARK: - UI Grid Item (Solo UX)
struct FavoriteGridItem: View {
    let pokemon: FavoritePokemon
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Spacer()
                Text("#\(pokemon.formattedID)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.gray.opacity(0.6))
                    .padding(.trailing, 8)
                    .padding(.top, 6)
            }
            
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 65)
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red.opacity(0.2))
            }

            Text(pokemon.name.capitalized)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

// MARK: - Preview
#Preview {
    FavoritesView(showMenu: .constant(false))
}

