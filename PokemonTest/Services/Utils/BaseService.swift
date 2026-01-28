//
//  BaseService.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 28-01-26.
//

import Foundation

class BaseService {
    func getEndpoint(fromName: String) -> APIEndpointModel? {
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
            print("⚠️ Error: No se pudo cargar el endpoint '\(fromName)' desde \(endpointFile)")
            return nil
        }
        
        return APIEndpointModel(
            url: url,
            BaseUrl: endpoint["baseurl"] ?? "",
            APIKey: endpoint["x-api-key"] ?? "",
            APIToken: endpoint["x-api-token"]
        )
    }
}
