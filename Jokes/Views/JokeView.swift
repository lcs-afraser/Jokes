//
//  JokeView.swift
//  Jokes
//
//  Created by Alistair Fraser on 2023-04-14.
//

import SwiftUI

struct JokeView: View {
    
    //MARK: Stored properties
    
    //0.0 is invisible, 1.0 is visible
    @State var punchlineOpacity = 0.0
    var body: some View {
        NavigationView {
            VStack {
                Text("You see, mountains aren't just funny")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button(action:  {
                    punchlineOpacity = 1.0
                }, label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .tint(.black)
                })
                Text("They are hill areas")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .opacity(punchlineOpacity)
            }
            .navigationTitle("Random Jokes")
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
