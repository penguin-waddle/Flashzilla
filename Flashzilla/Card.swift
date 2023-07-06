//
//  Card.swift
//  Flashzilla
//
//  Created by Vivien on 5/31/23.
//

import Foundation

struct Card: Codable {
    let id: UUID
    let prompt: String
    let answer: String

    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
