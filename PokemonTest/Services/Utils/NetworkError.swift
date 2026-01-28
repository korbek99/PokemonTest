//
//  NetworkError.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 28-01-26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case fileNotFound
    case invalidEndpoint
    case networkError(Error)
    case decodingError
    case badResponse(statusCode: Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Error interno: No se encontró el archivo de configuración."
        case .invalidEndpoint:
            return "Error de configuración: La dirección del servidor es inválida."
        case .networkError(let error):
            return "Problema de conexión: \(error.localizedDescription)"
        case .decodingError:
            return "Error al procesar los datos del servidor."
        case .badResponse(let code):
            return "El servidor respondió con un error (Código: \(code))."
        case .unknown:
            return "Ha ocurrido un error inesperado. Inténtalo de nuevo."
        }
    }
}
