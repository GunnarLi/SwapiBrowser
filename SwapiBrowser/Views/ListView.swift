//
//  ListView.swift
//  SwapiBrowser
//
//  Created by Admin on 30.07.23.
//

import SwiftUI

struct ListView: View {
    
    let apiService: SWApiService
    let context: Context
    
    var body: some View {
        VStack{
            switch context {
                case .film:
                    FilmList(apiService: apiService)
                case .character:
                    CharacterList(apiService: apiService)
                case .planet:
                    PlanetList(apiService: apiService)
            }
        }
    }
}



// list element view for category film
struct FilmList: View {

    let apiService: SWApiService
    @State private var allFilms = [Film]()
    
    var body: some View {
        
        if allFilms.isEmpty {
            ProgressView("Please be patient, loading all film data").scaleEffect(1.0, anchor: .center)
                .task {
                    let allFilms = await apiService.requestAllFilms()
                    self.allFilms = allFilms
            }
        } else {
            List(self.allFilms) { film in
                NavigationLink(destination: DetailView())
                {
                    HStack {
                        Text("\(film.title)")
                    }
                }
            }
        }
    }
}

// list element view for category character
struct CharacterList: View{
    let apiService: SWApiService
    @State private var allCharacters = [Character]()
    
    var body: some View {
        
        if allCharacters.isEmpty {
            ProgressView("Please be patient, load all character data").scaleEffect(1.0, anchor: .center)
                .task {
                    let allCharacters = await apiService.requestAllCharacters()
                    self.allCharacters = allCharacters
                }
        } else {
            List(self.allCharacters) { character in
                NavigationLink(destination: DetailView())
                {
                    HStack {
                        Text("\(character.name)")
                    }
                }
            }
        }
    }
}

// list element view for category planet
struct PlanetList: View {
    let apiService: SWApiService
    @State private var allPlanets = [Planet]()
    
    var body: some View {
        
        if allPlanets.isEmpty {
            ProgressView("Please be patient, load all planet data").scaleEffect(1.0, anchor: .center)
                .task {
                    let allPlanets = await apiService.requestAllPlanets()
                    self.allPlanets = allPlanets
                }
        } else {
            List(allPlanets) { planet in
                NavigationLink(destination: DetailView())
                {
                    HStack {
                        Text("\(planet.name)")
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(apiService: SWApiService(), context: .film)
    }
}
