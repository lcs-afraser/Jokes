//
//  FavouritesView.swift
//  Jokes
//
//  Created by Alistair Fraser on 2023-04-18.
//

import Blackbird
import SwiftUI

struct FavouritesView: View {
    //MARK: Stored properties
    
    //List of favourite jokes
    @BlackbirdLiveModels({ db in
        try await Joke.read(from: db)
    }) var favouriteJokes
    
    //MARK: Computed properties
    var body: some View {
        List(favouriteJokes.results) { currentJoke in
            VStack(alignment: .leading) {
                Text(currentJoke.setup)
                    .bold()
                Text(currentJoke.punchline)
            }
        }
        .navigationTitle("Favourite Jokes")
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
        //Make the database avaliable to this view in XCode previews
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
