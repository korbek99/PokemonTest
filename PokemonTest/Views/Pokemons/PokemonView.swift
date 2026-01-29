//
//  PokemonView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import SwiftUI

struct PokemonView: View {
    @StateObject private var viewModel = PokemonViewModel()
    @State private var searchText = ""
    @Binding var showMenu: Bool 
 
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var filteredPokemon: [PokemonResult] {
        if searchText.isEmpty {
            return viewModel.pokemonList
        } else {
            return viewModel.pokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.opacity(0.9)
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.red) // Cambiado a rojo para que se vea sobre blanco
                        .scaleEffect(1.5)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(filteredPokemon, id: \.name) { pokemon in
                                PokemonGridItem(pokemon: pokemon)
                            }
                        }
                        .padding()
                    }
                    .overlay {
                        if filteredPokemon.isEmpty && !searchText.isEmpty {
                            ContentUnavailableView.search(text: searchText)
                                // Quitamos el color blanco para que se vea en el fondo claro
                        }
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
                        Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                            .foregroundColor(.white)
                        Text("Pokédex")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Buscar Pokémon...")
            .toolbarBackground(Color.red, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .task {
                await viewModel.fetchPokemons()
            }
        }
    }
}

// MARK: - Grid Item
struct PokemonGridItem: View {
    let pokemon: PokemonResult
    
    private var rawID: String {
        pokemon.url.split(separator: "/").last?.description ?? "0"
    }

    private var formattedID: String {
        if let idInt = Int(rawID) {
            return String(format: "%03d", idInt)
        }
        return rawID
    }
    
    var body: some View {
        NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
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
                    
                    AsyncImage(url: AppConfig.pokemonImageUrl(for: rawID)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        case .failure(_):
                            Image(systemName: "bolt.horizontal.circle.fill")
                                .foregroundColor(.gray.opacity(0.3))
                        case .empty:
                            ProgressView().controlSize(.small)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .id(rawID)
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
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PokemonView(showMenu: .constant(false))
}
