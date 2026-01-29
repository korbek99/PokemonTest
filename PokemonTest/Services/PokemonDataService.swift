//
//  PokemonDataService.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 27-01-26.
//
import Foundation
import UIKit

// MARK: - Protocolo Actualizado
protocol PokemonServiceDataProtocol {
    func getArticles(pokemonId: String, completion: @escaping ([PokemonDetails]?) -> ())
}

// MARK: - Servicio
class PokemonDataService: BaseService, PokemonServiceDataProtocol {
    var urlbase: String = ""
    
    func getArticles(pokemonId: String) async throws -> [PokemonDetails] {
        guard let endpointData = getEndpoint(fromName: "crearDetails") else {
            throw NetworkError.invalidEndpoint
        }

        let fullURLString = endpointData.url.absoluteString + pokemonId
        
        guard let dynamicURL = URL(string: fullURLString) else {
            throw NetworkError.invalidEndpoint
        }
        
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(from: dynamicURL)
        } catch {
            throw NetworkError.networkError(error)
        }

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(PokemonDetails.self, from: data)
            return [decodedResponse]
        } catch {
            print("❌ Error de decodificación: \(error)")
            throw NetworkError.decodingError
        }
    }

    func getArticles(pokemonId: String, completion: @escaping ([PokemonDetails]?) -> ()) {
        Task {
            do {
                let result = try await getArticles(pokemonId: pokemonId)
                completion(result)
            } catch {
                print("❌ Service Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
