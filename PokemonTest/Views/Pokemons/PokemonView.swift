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
                Color.red.opacity(0.9)
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
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
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .navigationTitle("Pokédex")
            .searchable(text: $searchText, prompt: "Buscar...")
            .task {
                await viewModel.fetchPokemons()
            }
        }
    }
}

struct PokemonGridItem: View {
    let pokemon: PokemonResult
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 70)
                
                Image(systemName: "questionmark.circle.fill")
                    .foregroundColor(.gray.opacity(0.5))
                    .font(.system(size: 30))
            }
            
            Text(pokemon.name.capitalized)
                .font(.caption.bold())
                .foregroundColor(.primary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    PokemonView()
}
