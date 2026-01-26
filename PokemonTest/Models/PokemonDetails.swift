//
//  PokemonDetails.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//

import Foundation
import Foundation

struct PokemonDetails: Codable {
    let id: Int
    let baseExperience: Int
    let height: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let abilities: [AbilitySlot]
    let cries: Cries
    let forms: [NamedResource]
    let gameIndices: [GameIndex]
    let moves: [MoveElement]

    enum CodingKeys: String, CodingKey {
        case id, abilities, cries, forms, height, moves
        case baseExperience = "base_experience"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case gameIndices = "game_indices"
    }
}

struct AbilitySlot: Codable {
    let isHidden: Bool
    let slot: Int
    let ability: NamedResource

    enum CodingKeys: String, CodingKey {
        case slot, ability
        case isHidden = "is_hidden"
    }
}

struct NamedResource: Codable {
    let name: String
    let url: String
}

struct Cries: Codable {
    let latest: String
    let legacy: String
}

struct GameIndex: Codable {
    let gameIndex: Int
    let version: NamedResource

    enum CodingKeys: String, CodingKey {
        case version
        case gameIndex = "game_index"
    }
}

struct MoveElement: Codable {
    let move: NamedResource
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod: NamedResource
    let order: Int? 
    let versionGroup: NamedResource

    enum CodingKeys: String, CodingKey {
        case order
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}
