//
//  Joke.swift
//  Jokes
//
//  Created by Alistair Fraser on 2023-04-14.
//

import Blackbird
import Foundation

struct Joke: Identifiable, Codable, BlackbirdModel {
    @BlackbirdColumn var type: String
    @BlackbirdColumn var setup: String
    @BlackbirdColumn var punchline: String
    @BlackbirdColumn var id: Int
}
let exampleJoke = Joke(type: "general", setup: "How much does a hipster weigh?", punchline: "An Instagram", id: 146)
