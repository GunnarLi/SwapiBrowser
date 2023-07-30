//
//  SWObjectResponse.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import Foundation

protocol SWObject {}

/// maps to a request without out an id, which returns all elements of the wanted category.
///
/// The paging mechanic is implemented in SWApiService
/// 
struct SWPagingResponse: Decodable {

    let count: Int32
    let next: String?
    let previous: String?
    let results: [SWObjectWrapper]
    
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
     }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)

        count = try container.decode(Int32.self, forKey: .count)
        next = try container.decodeIfPresent(String.self, forKey: .next)
        previous = try container.decodeIfPresent(String.self, forKey: .previous)
        results = try container.decode([SWObjectWrapper].self, forKey: .results)
    }
}
