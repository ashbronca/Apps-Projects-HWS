//
//  ContentView.swift
//  Rock. Paper. Scissors.
//
//  Created by Ash Bronca on 31/8/21.
//

import SwiftUI

struct ContentView: View {
    enum RPSOptions: String {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
    }
    
    let possibleMoves: [RPSOptions] = [.rock, .paper, .scissors]
    let possibleMovesEmoji = ["✊", "✋", "✌️"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var playerResult = Bool.random()
    @State private var gameScore = 0
    @State private var totalScore = 10
    @State private var currentRound = 1
    @State private var showAlert = false
    @State private var answerText = ""
    @State private var answerAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("\(currentRound) / \(totalScore)")
                    .fontWeight(.bold)
                    .padding(.bottom, 100.0)
                Text("\(possibleMovesEmoji[appChoice])")
                    .font(.system(size: 100.0))
                    .padding(.bottom, 50.0)
                Divider()
                    .padding(.vertical, 20.0)
                Text("If I choose “\(possibleMoves[appChoice].rawValue)”")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding(.top, 20.0)
                Text(playerResult ? "and you have to win..." : "and you have to lose...")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20.0)
                Divider()
                    .padding(.vertical, 30.0)
                Text("What should be your choice?")
                    .fontWeight(.bold)
                    .padding(.top, 80.0)
                    .padding(.bottom, 50.0)
                HStack(spacing: 50.0) {
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
                .padding(.bottom, 150.0)
            }
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"),
                  message: Text("Your final score was \(gameScore).\nThanks for playing!"),
                  dismissButton: .default(Text("Play again")) {
                    self.resetGame()
                })
        }
        .alert(isPresented: $answerAlert) {
            Alert(title: Text(answerText),
                  dismissButton: .default(Text("Continue")) {
                    self.alertNextRound()
                })
        }
    }
    
    func checkSelection(move: RPSOptions) {
        if currentRound == 10 {
            gameOver()
        }
        
        switch possibleMoves[appChoice] {
        case .rock:
            if move == .paper {
                if playerResult == true {
                    gameScore += 1
                    answerText = """
                        That is correct!
                        Your score is \(gameScore) out of \(totalScore)
                        """
                    answerAlert = true
                } else if playerResult == false {
                    answerText = "Bummer, that is not correct!"
                    answerAlert = true
                }
            } else if move == .scissors {
                if playerResult == true {
                    answerText = "Bummer, that is not correct!"
                    answerAlert = true
                } else if playerResult == false {
                    gameScore += 1
                    answerText = """
                        That is correct!
                        Your score is \(gameScore) out of \(totalScore)
                        """
                    answerAlert = true
                }
            }
        case .paper:
            if move == .scissors {
                if playerResult == true {
                    gameScore += 1
                    answerText = """
                        That is correct!
                        Your score is \(gameScore) out of \(totalScore)
                        """
                    answerAlert = true
                } else if playerResult == false {
                    answerText = "Bummer, that is not correct!"
                    answerAlert = true
                }
            } else if move == .rock {
                if playerResult == true {
                    answerText = "Bummer, that is not correct!"
                    answerAlert = true
                } else if playerResult == false {
                    gameScore += 1
                    answerText = """
                        That is correct!
                        Your score is \(gameScore) out of \(totalScore)
                        """
                    answerAlert = true
                }
            }
        case .scissors:
            if move == .rock {
                if playerResult == true {
                    gameScore += 1
                    answerText = """
                        That is correct!
                        Your score is \(gameScore) out of \(totalScore)
                        """
                    answerAlert = true
                } else if playerResult == false {
                    answerText = "Bummer, that is not correct!"
                    answerAlert = true
                }
            } else if move == .paper {
                if playerResult == true {
                    answerText = "Bummer, that is not correct!"
                    answerAlert = true
                } else if playerResult == false {
                    gameScore += 1
                    answerText = """
                        That is correct!
                        Your score is \(gameScore) out of \(totalScore)
                        """
                    answerAlert = true
                }
            }
        }
        nextRound()
    }
    
    func alertNextRound() {
        appChoice = Int.random(in: 0...2)
        playerResult = Bool.random()
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
