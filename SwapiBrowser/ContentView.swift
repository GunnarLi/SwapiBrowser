//
//  ContentView.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import SwiftUI

struct ContentView: View {
    
    let swapiService = SwapiService()
    let filmUrl = "films/"
    let peopleUrl = "people/"
    let planetUrl = "planets/"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear{
            self.setupService()
        }
    }
    
    private func setupService() {
        Task {
            async let film = swapiService.requestFilm(with: "1")
            async let character = swapiService.requestCharacter(with: "1")
            async let planet = swapiService.requestCharacter(with: "1")

            let results = await [film, character, planet]
//            let films = await swapiService.requestAllFilms()
//            async let characters = swapiService.requestAllCharacters()
//            async let planets = swapiService.requestAllPlanets()
            
//            let results = await [films, characters, planets] as [Any]
            print("ready")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

