//
//  SWObjectWrapper.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import Foundation

enum SWObjectWrapper: Decodable {
    case film(Film)
    case character(Character)
    case planet(Planet)
    case unknown
    
    enum CodingKeys: CodingKey, CaseIterable {
        case url
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleContainer = try decoder.singleValueContainer()
        let name = try container.decodeIfPresent(String.self, forKey: .url)
        
        guard let name = name else {
            self = SWObjectWrapper.unknown
            return
        }
        
        switch name {
            case _ where name.contains("https://swapi.dev/api/films"):
                let value = try singleContainer.decode(Film.self)
                self = SWObjectWrapper.film(value)
            case _ where name.contains("https://swapi.dev/api/people"):
                let value = try singleContainer.decode(Character.self)
                self = SWObjectWrapper.character(value)
            case _ where name.contains("https://swapi.dev/api/planets"):
                let value = try singleContainer.decode(Planet.self)
                self = SWObjectWrapper.planet(value)
            default:
                self = SWObjectWrapper.unknown
        }
    }
}

/// needs to be extended when a new type is introduced
extension SWObjectWrapper {
    
    func asFilm() -> Film? {
        switch self {
            case .film(let film): return film
            default: return nil
        }
    }
    
    func asCharacter() -> Character? {
        switch self {
            case .character(let character): return character
            default: return nil
        }
    }
    
    func asPlanet() -> Planet? {
        switch self {
            case .planet(let planet): return planet
            default: return nil
        }
    }
}
