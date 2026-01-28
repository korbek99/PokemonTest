//
//  AppConfig.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 28-01-26.
//

import Foundation

struct AppConfig {
    static let pokemonImageBaseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    
    static func pokemonImageUrl(for id: String) -> URL? {
        return URL(string: "\(pokemonImageBaseURL)\(id).png")
    }
}
