//
//  FavoritePoke.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 29-01-26.
//

import Foundation
import SwiftData

@Model
final class FavoritePoke: Identifiable {
    @Attribute(.unique) var id: Int
    var name: String
    var dateAdded: Date 
    
    init(id: Int, name: String, dateAdded: Date = .now) {
        self.id = id
        self.name = name
        self.dateAdded = dateAdded
    }
}
