//
//  ContentView.swift
//  Flashzilla
//
//  Created by Vivien on 5/31/23.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @ObservedObject var store: CardStore = CardStore()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(store.cards, id: \.id) { card in
                                CardView(card: card) { isCorrect in
                                    withAnimation {
                                        if let index = store.cards.firstIndex(where: { $0.id == card.id }) {
                                            removeCard(at: index, isCorrect: isCorrect)
                                        }
                                    }
                                }
                                .stacked(at: store.cards.firstIndex(where: { $0.id == card.id }) ?? 0, in: store.cards.count)
                                .allowsHitTesting(card.id == store.cards.last?.id)
                                .accessibilityHidden(card.id != store.cards.last?.id)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if store.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: store.cards.count - 1, isCorrect: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: store.cards.count - 1, isCorrect: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if store.cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
  //  func loadData() {
  //      if let data = UserDefaults.standard.data(forKey: "Cards") {
  //          if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
  //              store.cards = decoded
  //          }
  //      }
  //  }
    
    func removeCard(at index: Int, isCorrect: Bool) {
            guard index >= 0 else { return }

        let card = store.cards.remove(at: index)

            // Only re-insert the card if the answer was not correct
            if !isCorrect {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    store.cards.insert(card, at: 0)
                }
            }

        if store.cards.isEmpty {
                isActive = false
            }
        }

    
    func resetCards() {
        timeRemaining = 100
        isActive = true
       // loadData()
        store.loadCards()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
