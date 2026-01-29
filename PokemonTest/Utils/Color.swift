//
//  Color.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 29-01-26.
//

import Foundation
import SwiftUI

extension Color {
    static func pokemonTypeColor(type: String) -> Color {
        switch type.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "psychic": return .pink
        case "ice": return .cyan
        case "dragon": return .indigo
        case "ghost": return .purple
        case "dark": return .black
        case "fighting": return .orange
        case "poison": return Color(red: 0.6, green: 0.3, blue: 0.6)
        case "ground": return .brown
        case "rock": return Color(white: 0.4)
        case "bug": return Color(red: 0.6, green: 0.7, blue: 0.1)
        case "steel": return .gray
        case "fairy": return .pink.opacity(0.6)
        default: return .gray 
        }
    }
}
