//
//  PokemonDataService.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 27-01-26.
//
import Foundation
import UIKit

protocol PokemonServiceDataProtocol {
    func getArticles(completion: @escaping ([PokemonDetails]?) -> ())
}

class PokemonDataService: PokemonServiceDataProtocol {
    var urlbase: String = ""
    func getArticles() async throws -> [PokemonDetails] {
        guard let endpointData = getEndpoint(fromName: "crearPokemon") else {
            throw URLError(.badURL)
        }
        
        let url = endpointData.url
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode([PokemonDetails].self, from: data)
        
        return response
    }
    
    // Implementación del protocolo
    func getArticles(completion: @escaping ([PokemonDetails]?) -> ()) {
        Task {
            do {
                let result = try await getArticles()
                completion(result)
            } catch {
                print("Error: \(error)")
                completion(nil)
            }
        }
    }

    public func getEndpoint(fromName: String) -> APIEndpointModel? {
        let endpointFile: String
        #if DEBUG
            endpointFile = "endpointsDev"
        #else
            endpointFile = "endpoints"
        #endif
        
        guard let path = Bundle.main.path(forResource: endpointFile, ofType: "plist"),
              let myDict = NSDictionary(contentsOfFile: path) as? [String : Any],
              let endpoint = myDict[fromName] as? [String : String],
              let urlString = endpoint["url"],
              let url = URL(string: urlString) else {
            return nil
        }
        
        return APIEndpointModel(
            url: url,
            APIKey: endpoint["x-api-key"] ?? "",
            APIToken: endpoint["x-api-token"]
        )
    }
}
