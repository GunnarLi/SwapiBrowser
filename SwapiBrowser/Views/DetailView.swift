//
//  DetailView.swift
//  SwapiBrowser
//
//  Created by Admin on 30.07.23.
//

import SwiftUI


struct DetailView: View {
    
    var body: some View {
        NavigationView{
        }.navigationBarTitle("DetailView")
    }
}

/// Details for films
struct DetailViewFilm: View {
    
    let film: Film
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Title: \(film.title)")
            Text("Episode : \(film.episodeID)")
            Text("Director: \(film.director)")
            Text("Producer \(film.producer)")
            Text("ReleaseDate: \(film.releaseDate)")
            Text("OpeningCrawl: \(film.episodeID)")

        }.navigationBarTitle("Film")
    }
}

/// Details for Characters
struct DetailViewCharacter: View {
    
    let character: Character
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Name: \(character.name)")
            Text("height : \(character.height)")
            Text("Mass: \(character.mass)")
            Text("Hair Color: \(character.hairColor)")
            Text("Skin Color: \(character.skinColor)")
            Text("Eye Color: \(character.eyeColor)")
            Text("Birth Year: \(character.birthYear)")
            Text("Gender: \(character.gender)")
        }.navigationBarTitle("Character")
    }
}

// Details for planets
struct DetailViewPlanet: View {
    
    let planet: Planet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Name: \(planet.name)")
            Text("Rotation Period : \(planet.rotationPeriod)")
            Text("Orbital Period: \(planet.orbitalPeriod)")
            Text("Diameter: \(planet.diameter)")
            Text("Climate: \(planet.climate)")
            Text("Gravity: \(planet.gravity)")
            Text("Terrain: \(planet.terrain)")
            Text("Surface Water: \(planet.surfaceWater)")
            Text("Population: \(planet.population)")
        }.navigationBarTitle("Planet")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(apiService: SWApiService(), context: .film)
    }
}

