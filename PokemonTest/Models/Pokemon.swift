//
//  Pokemon.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//


import Foundation


struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}

struct PokemonResult: Codable {
    let name: String
    let url: String
}
