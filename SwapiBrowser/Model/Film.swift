//
//  Film.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import Foundation

/// maps to the https://swapi.dev/api/films/<id> response
struct Film: Decodable, SWObject, Equatable {
    
    static func == (lhs: Film, rhs: Film) -> Bool {
        return lhs.url == rhs.url
    }
    
    let url: String
    let title: String
    let episodeID: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let created: String
    let edited: String
    let characters: [String]
    let planets: [String]
    let starships: [String]
    let vehicles: [String]
    let species: [String]
    
    private enum CodingKeys: String, CodingKey {
        case url = "url"
        case title = "title"
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director = "director"
        case producer = "producer"
        case releaseDate = "release_date"
        case created = "created"
        case edited = "edited"
        case characters = "characters"
        case planets = "planets"
        case starships = "starships"
        case vehicles = "vehicles"
        case species = "species"
    }
}
