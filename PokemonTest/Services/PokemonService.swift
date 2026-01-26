//
//  PokemonService.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//

import UIKit
protocol PokemonServiceProtocol {
    func getArticles( completion: @escaping ([PokemonResult]?) -> ())
}
class PokemonService: PokemonServiceProtocol {
    var urlbase: String = ""

    func getArticles() async throws -> [PokemonResult] {
        guard let endpointData = getEndpoint(fromName: "crearPokemon") else {
            throw URLError(.badURL)
        }
        
        let url = endpointData.url
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(PokemonResponse.self, from: data)
        return response.results ?? []
    }
    
    func getArticles(completion: @escaping ([PokemonResult]?) -> ()) {
        Task {
            let result = try? await getArticles()
            completion(result)
        }
    }

    public func getEndpoint(fromName: String) -> APIEndpointModel? {
        var endpointFile = ""
        #if DEBUG
            endpointFile = "endpointsDev"
        #else
            endpointFile = "endpoints"
        #endif
        
        guard let path = Bundle.main.path(forResource: endpointFile, ofType: "plist"),
              let myDict = NSDictionary(contentsOfFile: path) as? [String : Any],
              let endpoint = myDict[fromName] as? [String : String] else {
            return nil
        }
        
        return APIEndpointModel(url: URL(string: endpoint["url"]!)!,
                                APIKey: endpoint["x-api-key"]!,
                                APIToken: endpoint["x-api-token"])
    }
}
