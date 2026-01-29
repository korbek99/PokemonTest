//
//  PokemonDetailViewModel.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 27-01-26.
//

import Foundation

@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonList: [PokemonDetails] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = PokemonDataService()

    func fetchPokemons(pokemonId: String) async {
        isLoading = true
        errorMessage = nil
        
        do {

            let data = try await service.getArticles(pokemonId: pokemonId)
            self.pokemonList = data
        } catch {
            self.errorMessage = "Error al obtener los datos: \(error.localizedDescription)"
            print("Error: \(error)")
        }
        
        isLoading = false
    }
}
