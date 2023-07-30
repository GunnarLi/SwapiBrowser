//
//  SWObjectWrapper.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import Foundation

// #MARK: -
// #MARK: Decodable methods
// #TODO: needs to be extended in case of new category

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
        let url = try container.decodeIfPresent(String.self, forKey: .url)
        
        guard let url = url else {
            self = SWObjectWrapper.unknown
            return
        }
        
        
        switch url {
            case _ where url.contains(Context.film.path):
                let value = try singleContainer.decode(Film.self)
                self = SWObjectWrapper.film(value)
            case _ where url.contains(Context.character.path):
                let value = try singleContainer.decode(Character.self)
                self = SWObjectWrapper.character(value)
            case _ where url.contains(Context.planet.path):
                let value = try singleContainer.decode(Planet.self)
                self = SWObjectWrapper.planet(value)
            default:
                self = SWObjectWrapper.unknown
        }
    }
}

// #MARK: -
// #MARK: Category methods
// #TODO: needs to be extended in case of new category


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
