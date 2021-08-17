//
//  ContentView.swift
//  Brain Training
//
//  Created by Ash Bronca on 4/8/21.
//

import SwiftUI

struct ContentView: View {
    
    enum RPSOptions: String {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
    }
        
    let possibleMoves: [RPSOptions] = [.rock, .paper, .scissors]
    let possibleMovesEmojis = ["✊", "✋", "✌️"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var playerResult = Bool.random()
    @State private var gameScore = 0
    @State private var currentRound = 1
    @State private var showAlert = false

    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                Text("\(possibleMovesEmojis[appChoice])")
                Text("If I choose “\(possibleMoves[appChoice].rawValue)”")
                Text(playerResult ? "and you have to win..." : "and you have to lose...")
                Text("What should be your choice?")
                
                HStack(spacing: 50) {
                    Button(action: {
                        self.checkSelection(move: .rock)
                    }) {
                        Text("\(RPSOptions.rock.rawValue)")
                    }
                    Button(action: {
                        self.checkSelection(move: .paper)
                    }) {
                        Text("\(RPSOptions.paper.rawValue)")
                    }
                    Button(action: {
                        self.checkSelection(move: .scissors)
                    }) {
                        Text("\(RPSOptions.scissors.rawValue)")
                    }
                }
            }
            navigationBarTitle("RPS Training")
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"),
                message: Text("Your final score was \(gameScore).\nThanks for playing!"),
                dismissButton: .default(Text("Play again")) {
                    self.resetGame()
                })
        }
    }
    
    func checkSelection(move: RPSOptions){
        if currentRound == 10 {
            gameOver()
            return
        }
        
        switch possibleMoves[appChoice] {
        case .rock:
            if move == .paper {
                gameScore += playerResult ? 1 : -1;
            } else {
                gameScore += !playerResult ? 1 : -1;
            }
        case .paper:
            if move == .scissors {
                gameScore += playerResult ? 1 : -1;
            } else {
                gameScore += !playerResult ? 1 : -1
            }
        case .scissors:
            if move == .rock {
                gameScore += playerResult ? 1 : -1
            } else {
                gameScore += !playerResult ? 1 : -1
            }
        }
        nextRound()
    }
    
    func nextRound() {
        appChoice = Int.random(in: 0...2)
        playerResult = Bool.random()
        currentRound += 1
    }
    
    func gameOver() {
        showAlert = true
    }
    
    func resetGame() {
        gameScore = 0
        currentRound = 0
        nextRound()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

