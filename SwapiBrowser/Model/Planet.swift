//
//  Planet.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import Foundation

/// maps to the https://swapi.dev/api/planets/<id> response
struct Planet: Codable, SWObject, Equatable, Identifiable {
    
    static func == (lhs: Planet, rhs: Planet) -> Bool {
        return lhs.url == rhs.url
    }
    let id = UUID()
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String

    private enum CodingKeys: String, CodingKey {

        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surfaceWater = "surface_water"
        case population = "population"
        case residents = "residents"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
}
