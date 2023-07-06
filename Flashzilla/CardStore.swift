//
//  CardStore.swift
//  Flashzilla
//
//  Created by Vivien on 6/6/23.
//

import Foundation

class CardStore: ObservableObject {
    @Published var cards = [Card]()

    private var savePath: URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsPath.appendingPathComponent("cards.json")
    }

    init() {
        loadCards()
    }

    func loadCards() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print("Failed to load cards: \(error.localizedDescription)")
            cards = []
        }
    }

    func saveCards() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: .atomicWrite)
        } catch {
            print("Failed to save cards: \(error.localizedDescription)")
        }
    }
}
