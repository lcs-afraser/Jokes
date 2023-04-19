//
//  JokeView.swift
//  Jokes
//
//  Created by Alistair Fraser on 2023-04-14.
//

import Blackbird
import SwiftUI

struct JokeView: View {
    
    //MARK: Stored properties
    
    //Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    //0.0 is invisible, 1.0 is visible
    @State var punchlineOpacity = 0.0
    
    //The current joke to display
    @State var currentJoke: Joke?
    
    //MARK: Computed properties
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                if let currentJoke = currentJoke {
                    //Show the joke if it can be unwrapped(if currentJoke is not nil
                    Text(currentJoke.setup)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    Button(action:  {
                        withAnimation(.easeIn(duration: 1.0)) {
                            punchlineOpacity = 1.0
                        }
                    }, label: {
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .tint(.black)
                    })
                    Text(currentJoke.punchline)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .opacity(punchlineOpacity)
                    
                } else {
                    //Show a spinning wheel indicator until the joke is loaded
                    ProgressView()
                }
                
                Spacer()
                Button(action: {
                    // Reset the interface
                    punchlineOpacity = 0.0
                    
                    Task {
                        // Get another joke
                        withAnimation {
                            currentJoke = nil
                        }
                        currentJoke = await NetworkService.fetch()
                    }
                }, label: {
                    Text("Fetch another one")
                })
                .disabled(punchlineOpacity == 0.0 ? true : false)
                .buttonStyle(.borderedProminent)
                
                Button (action: {
                    
                    Task {
                        //Write to database
                        if let currentJoke = currentJoke {
                            try await db!.transaction { core in
                                try core.query("INSERT INTO Joke (id, type, setup, punchline) VALUES (?, ?, ?, ?)",
                                               currentJoke.id,
                                               currentJoke.type,
                                               currentJoke.setup,
                                               currentJoke.punchline)
                            }
                        }
                    }
                }, label: {
                    Text("Save for later")
                })
                //Disable button until punchline is shown
                .disabled(punchlineOpacity == 0.0 ? true : false)
                //Use another colour to differentiate from first button
                .tint(.green)
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Random Jokes")
        }
        //Create an asynchronous task to be performed as this view appears
        .task {
            if currentJoke == nil {
                currentJoke = await NetworkService.fetch()
            }
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
        //Make the database avaliable to this view in XCode previews
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
