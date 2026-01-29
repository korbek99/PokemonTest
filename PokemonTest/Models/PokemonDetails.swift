//
//  PokemonDetails.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import Foundation

struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let abilities: [AbilitySlot]
    let cries: Cries
    let forms: [NamedResource]
    let gameIndices: [GameIndex]
    let moves: [MoveElement]
    let stats: [StatSlot]
    let types: [TypeSlot]

    enum CodingKeys: String, CodingKey {
        case id, name, abilities, cries, forms, height, moves, weight, stats, types
        case baseExperience = "base_experience"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case gameIndices = "game_indices"
    }
}

struct StatSlot: Codable {
    let baseStat: Int
    let effort: Int
    let stat: NamedResource

    enum CodingKeys: String, CodingKey {
        case effort, stat
        case baseStat = "base_stat"
    }
}

struct TypeSlot: Codable {
    let slot: Int
    let type: NamedResource
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
    let versionGroup: NamedResource

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}
