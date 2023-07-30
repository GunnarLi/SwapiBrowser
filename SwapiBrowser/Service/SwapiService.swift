//
//  SwapiService.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//
//

import Foundation

/// This is the service class for the Star Wars Api.
///
/// - it provides typed methods to load single items for each supported category (e.g. requestFilm())
/// - it provides typed methods to load all data for a categy (e.g. requestAllFilms())
/// - the responses for the load all data methods are beeing cached after the first request, so no uneccessary requests are fired
/// - the current paging mechanism of the SWApi is supported
///
class SWApiService: ObservableObject {
    
    let httpService = HttpService()
    
    var allFilms = [Film]()
    var allCharacters = [Character]()
    var allPlanets = [Planet]()

    func requestFilm(with id: String) async -> Film? {
        return await httpService.requestType(urlString: "\(Context.film.path)\(id)", type: Film.self)
    }
    
    func requestCharacter(with id: String)  async -> Character? {
        return await httpService.requestType(urlString: "\(Context.character.path)\(id)", type: Character.self)
    }
    
    func requestPlanet(with id: String)  async -> Planet? {
        return await httpService.requestType(urlString: "\(Context.planet.path)\(id)", type: Planet.self)
    }
    
    func requestAllFilms() async -> [Film] {
        if allFilms.count == 0 {allFilms = await self.requestAllData(for: Context.film.path).asFilmList()}
        return allFilms
    }
    
    func requestAllCharacters() async -> [Character] {
        if allCharacters.count == 0 {allCharacters = await self.requestAllData(for: Context.character.path).asCharacterList()}
        return allCharacters
    }
    
    func requestAllPlanets() async -> [Planet] {
        if allPlanets.count == 0 {allPlanets = await self.requestAllData(for: Context.planet.path).asPlanetList()}
        return allPlanets
    }
}

/// private implementations
extension SWApiService {

    // implements the paging method of the SWApi. It loads all data until value 'next' of the response become nil
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
