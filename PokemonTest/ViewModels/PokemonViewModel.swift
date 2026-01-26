//
//  PokemonViewModel.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//


import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonResult] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = PokemonService()
    
    func fetchPokemons() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await service.getArticles()
            self.pokemonList = data
        } catch {
            self.errorMessage = "Error al obtener los datos: \(error.localizedDescription)"
            print("Error: \(error)")
        }
        
        isLoading = false
    }
}
