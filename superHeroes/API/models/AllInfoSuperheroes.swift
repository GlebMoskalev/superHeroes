//
//  AllInfoSuperheroes.swift
//  superHeroes
//
//  Created by Глеб Москалев on 29.04.2024.
//

import Foundation

// MARK: - AllInfoSuperheroes
struct AllInfoSuperheroes: Codable {
    let response, id, name: String
    let powerstats: Powerstats
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections
    let image: Image
}

// MARK: - Appearance
struct Appearance: Codable {
    let gender, race: String
    let height, weight: [String]
    let eyeColor, hairColor: String

    enum CodingKeys: String, CodingKey {
        case gender, race, height, weight
        case eyeColor = "eye-color"
        case hairColor = "hair-color"
    }
}

// MARK: - Biography
struct Biography: Codable {
    let fullName, alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance, publisher, alignment: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full-name"
        case alterEgos = "alter-egos"
        case aliases
        case placeOfBirth = "place-of-birth"
        case firstAppearance = "first-appearance"
        case publisher, alignment
    }
}

// MARK: - Connections
struct Connections: Codable {
    let groupAffiliation, relatives: String

    enum CodingKeys: String, CodingKey {
        case groupAffiliation = "group-affiliation"
        case relatives
    }
}

// MARK: - Image
struct Image: Codable {
    let url: String
}

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence, strength, speed, durability: String
    let power, combat: String
}

// MARK: - Work
struct Work: Codable {
    let occupation, base: String
}
