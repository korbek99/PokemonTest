//
//  FavoritesView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import SwiftUI
import SwiftData

struct FavoritesView: View {
    
    @Query(sort: \FavoritePoke.name) private var favoritePokemons: [FavoritePoke]
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchText = ""
    @Binding var showMenu: Bool
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
  
    var filteredPokemon: [FavoritePoke] {
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
                
                if favoritePokemons.isEmpty {
                    ContentUnavailableView("No hay favoritos",
                                           systemImage: "heart.slash",
                                           description: Text("Tus Pokémon marcados aparecerán aquí."))
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(filteredPokemon) { pokemon in
                                
                                FavoriteGridItem(pokemon: pokemon)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            modelContext.delete(pokemon)
                                        } label: {
                                            Label("Eliminar de favoritos", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding()
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

// MARK: - UI Grid Item
struct FavoriteGridItem: View {
    let pokemon: FavoritePoke

    private var formattedID: String {
        String(format: "%03d", pokemon.id)
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Spacer()
                Text("#\(formattedID)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.gray.opacity(0.6))
                    .padding(.trailing, 8)
                    .padding(.top, 6)
            }
            
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 65)

                AsyncImage(url: AppConfig.pokemonImageUrl(for: String(pokemon.id))) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 55, height: 55)
                    } else if phase.error != nil {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.red.opacity(0.2))
                    } else {
                        Image(systemName: "bolt.horizontal.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray.opacity(0.2))
                    }
                }
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
        .modelContainer(for: FavoritePoke.self, inMemory: true)
}
