//
//  JokesApp.swift
//  Jokes
//
//  Created by Alistair Fraser on 2023-04-14.
//

import SwiftUI

@main
struct JokesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                JokeView()
                    .tabItem {
                        Label("Fresh", systemImage: "carrot")
                    }
                
                FavouritesView()
                    .tabItem {
                        Label("Favourites", systemImage: "face.smiling")
                    }
            }
            //Make the database avaliable to all child views through the environment
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
