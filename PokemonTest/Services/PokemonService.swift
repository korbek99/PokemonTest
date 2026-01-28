//
//  PokemonService.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import Foundation
import UIKit


protocol PokemonServiceProtocol {
    func getArticles(completion: @escaping ([PokemonResult]?) -> ())
}

class PokemonService: BaseService, PokemonServiceProtocol {
    var urlbase: String = ""
    func getArticles() async throws -> [PokemonResult] {
     
        guard let endpointData = getEndpoint(fromName: "crearPokemon") else {
            throw NetworkError.invalidEndpoint
        }
        
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(from: endpointData.url)
        } catch {
            throw NetworkError.networkError(error)
        }

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
        }

        do {
            let decodedResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
            return decodedResponse.results ?? []
        } catch {
            print("❌ Error de decodificación en lista: \(error)")
            throw NetworkError.decodingError
        }
    }
    
    func getArticles(completion: @escaping ([PokemonResult]?) -> ()) {
        Task {
            do {
                let result = try await getArticles()
                completion(result)
            } catch {
                print("❌ Service Error (List): \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
