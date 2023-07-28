//
//  SwapiService.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import Foundation

class SwapiService {
    
    let filmPath = "https://swapi.dev/api/films/"
    let characterPath = "https://swapi.dev/api/people/"
    let planetPath = "https://swapi.dev/api/planets/"
    
    let httpService = HttpService()

    var allFilms = [Film]()
    var allCharacters = [Character]()
    var allPlanets = [Planet]()

    func requestAllFilms() async -> [Film] {
        if allFilms.count == 0 {allFilms = await self.requestAllData(for: filmPath).asFilmList()}
        return allFilms
    }
    
    func requestAllCharacters() async -> [Character] {
        if allCharacters.count == 0 {allCharacters = await self.requestAllData(for: characterPath).asCharacterList()}
        return allCharacters
    }
    
    func requestAllPlanets() async -> [Planet] {
        if allPlanets.count == 0 {allPlanets = await self.requestAllData(for: planetPath).asPlanetList()}
        return allPlanets
    }

    func requestFilm(with id: String) async -> Film? {
        return await httpService.requestType(urlString: "\(filmPath)\(id)", type: Film.self)
    }

    func requestCharacter(with id: String)  async -> Character? {
        return await httpService.requestType(urlString: "\(characterPath)\(id)", type: Character.self)
    }

    func requestPlanet(with id: String)  async -> Planet? {
        return await httpService.requestType(urlString: "\(characterPath)\(id)", type: Planet.self)
    }
  
    private func requestAllData(for urlString: String) async -> SWWrapperList {
        var tmpPath = urlString
        var allResults = [SWObjectWrapper]()
        var finished: Bool  = false
        while !finished {
            if let response: SWPagingResponse = await httpService.requestType(urlString: tmpPath, type: SWPagingResponse.self) {
                allResults.append(contentsOf: response.results)
                if let nextUrl = response.next {
                    tmpPath = nextUrl
                } else {
                    finished = true
                }
            } else {
                finished = true
            }
        }
        return SWWrapperList(wrappers: allResults)
    }
}

//
struct SWWrapperList {
    let wrappers: [SWObjectWrapper]
    
    func asFilmList()       -> [Film] {return wrappers.compactMap{$0.asFilm()}}
    func asCharacterList()  -> [Character] {return wrappers.compactMap{$0.asCharacter()}}
    func asPlanetList()     -> [Planet] {return wrappers.compactMap{$0.asPlanet()}}
}

