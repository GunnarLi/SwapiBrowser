//
//  Context.swift
//  SwapiBrowser
//
//  Created by Admin on 30.07.23.
//

/// Enum to define currently supported contexts
enum Context {
    case film
    case character
    case planet

    // the enum could be a typed enum (String), but it is used in more than the path context,
    // so i decided to not implement an Enum with type string but implement the path as a var of the emum
    var path: String {
        switch self {
            case .film:         return "https://swapi.dev/api/films/"
            case .character:    return "https://swapi.dev/api/people/"
            case .planet:       return "https://swapi.dev/api/planets/"
        }
    }
}
