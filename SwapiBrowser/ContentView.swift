//
//  ContentView.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import SwiftUI

struct ContentView: View {
    
    let apiService = SWApiService()
    
    @State var showMovies = false
    @State var showCharacters = false
    @State var showPlanets = false
    
    // TODO: modify search value as you like
    var body: some View {
        NavigationView {
            VStack {
                
                Text("SWApiReader").font(.title)
                Spacer().frame(height: 48)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer().frame(height: 64)
                
                VStack()
                {
                    MenuButton(buttonTitle: "Learn more about Star Wars Movies") {
                        showMovies = true
                    }
                    .padding(8)
                    
                    MenuButton(buttonTitle: "Learn more about Star Wars Characters") {
                        showCharacters = true
                    }
                    .padding(8)
                    MenuButton(buttonTitle: "Learn Learn more about Star Wars Planets") {
                        showPlanets = true
                    }
                    .padding(8)
                    
                    NavigationLink(destination: ListView(
                        apiService: apiService, context: .film),
                                   isActive: $showMovies) {}
                    
                    NavigationLink(destination: ListView(
                        apiService: apiService, context: .character),
                                   isActive: $showCharacters) {}
                    
                    NavigationLink(destination: ListView(
                        apiService: apiService, context: .planet),
                                   isActive: $showPlanets) {}
                }
                Spacer()
                Text("Made by Gunnar")
            }
            .padding()
        }
    }
}

struct MenuButton: View {
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        Button(buttonTitle, action: action)
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//    private func setupService() {
//        Task {
//            async let film = swapiService.requestFilm(with: "1")
//            async let character = swapiService.requestCharacter(with: "1")
//            async let planet = swapiService.requestCharacter(with: "1")
//
//            let results = await [film, character, planet]
////            let films = await swapiService.requestAllFilms()
////            async let characters = swapiService.requestAllCharacters()
////            async let planets = swapiService.requestAllPlanets()
//
////            let results = await [films, characters, planets] as [Any]
//            print("ready")
//        }
//    }
//}
