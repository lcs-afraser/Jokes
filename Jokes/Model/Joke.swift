//
//  Joke.swift
//  Jokes
//
//  Created by Alistair Fraser on 2023-04-14.
//

import Foundation

struct Joke: Identifiable, Codable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}
let exampleJoke = Joke(type: "general", setup: "How much does a hipster weigh?", punchline: "An Instagram", id: 146)
