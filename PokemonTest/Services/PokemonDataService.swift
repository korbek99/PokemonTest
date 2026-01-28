//
//  PokemonDataService.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 27-01-26.
//
import Foundation
import UIKit

// MARK: - Protocolo
protocol PokemonServiceDataProtocol {
    func getArticles(completion: @escaping ([PokemonDetails]?) -> ())
}

// MARK: - Servicio
class PokemonDataService: BaseService,  PokemonServiceDataProtocol {
    var urlbase: String = ""
 
    func getArticles() async throws -> [PokemonDetails] {
        
        guard let endpointData = getEndpoint(fromName: "crearDetails") else {
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
            let decodedResponse = try JSONDecoder().decode([PokemonDetails].self, from: data)
            return decodedResponse
        } catch {
            print("❌ Error de decodificación: \(error)")
            throw NetworkError.decodingError
        }
    }


    func getArticles(completion: @escaping ([PokemonDetails]?) -> ()) {
        Task {
            do {
                let result = try await getArticles()
                completion(result)
            } catch {
                print("❌ Service Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}

