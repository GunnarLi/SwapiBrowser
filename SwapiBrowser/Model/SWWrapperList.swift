//
//  SWWrapperList.swift
//  SwapiBrowser
//
//  Created by Admin on 30.07.23.
//

import Foundation

struct SWWrapperList {
    let wrappers: [SWObjectWrapper]

    // #TODO: needs to be extended in case of new category
    func asFilmList()       -> [Film] {return wrappers.compactMap{$0.asFilm()}}
    func asCharacterList()  -> [Character] {return wrappers.compactMap{$0.asCharacter()}}
    func asPlanetList()     -> [Planet] {return wrappers.compactMap{$0.asPlanet()}}
}
