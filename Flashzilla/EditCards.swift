//
//  EditCards.swift
//  Flashzilla
//
//  Created by Vivien on 6/6/23.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: CardStore = CardStore()
    @State private var newPrompt = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }

                Section {
                    ForEach(0..<store.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(store.cards[index].prompt)
                                .font(.headline)
                            Text(store.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: store.loadCards)
        }
    }

    func done() {
        dismiss()
    }

   // func loadData() {
   //     if let data = UserDefaults.standard.data(forKey: "Cards") {
   //         if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
   //             store.cards = decoded
   //         }
   //     }
   // }

  //  func saveData() {
  //      if let data = try? JSONEncoder().encode(store.cards) {
  //          UserDefaults.standard.set(data, forKey: "Cards")
  //      }
  //  }

    func addCard() {
           let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
           let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
           guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

           let card = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer)
           store.cards.insert(card, at: 0)
           store.saveCards()
           
           self.newPrompt = ""
           self.newAnswer = ""
       }

       func removeCards(at offsets: IndexSet) {
           store.cards.remove(atOffsets: offsets)
           store.saveCards()
       }
   }

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
