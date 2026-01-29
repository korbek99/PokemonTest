//
//  Entrenador.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 29-01-26.
//

import Foundation
import SwiftData

@Model
class Entrenador {
    var nombre: String
    var email: String
    var password: String
    var fechaRegistro: Date
    
    init(nombre: String, email: String, password: String) {
        self.nombre = nombre
        self.email = email
        self.password = password
        self.fechaRegistro = Date()
    }
}
