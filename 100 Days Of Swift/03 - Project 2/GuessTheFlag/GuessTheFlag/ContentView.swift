//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ash Bronca on 30/7/21.
//

import SwiftUI

struct ContentView: View {
    // array to show available countries
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    // variable to create a random number between 0-3
    @State private var correctAnswer = Int.random(in: 0...2)
    // variable to create boolean score for alert
    @State private var showingScore = false
    // score title variable - answer outcome
    @State private var scoreTitle = ""
    // variable to hold default score of 0
    @State private var score = 0
    
    // function for tapping the flag - take in the int index num
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1 // assign score the updated score
        } else { // if this is not correct, display the name of the country that was tapped
            scoreTitle = "Incorrect, that is the flag of \(countries[number])"
        }
        // set the showing score variable to true
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    

    var body: some View {
        // ZStack to hold H and S stacks
        ZStack {
            // set gradient colour for the screen
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                // overwrite all safe areas with gradient colour
                .edgesIgnoringSafeArea(.all)

            // create spacing for VStack
            VStack(spacing: 30) {
                VStack {
                    // text field at the top of screen
                    Text("Tap the flag of")
                        // set colour of text to white
                        .foregroundColor(.white)
                    
                    // display selected country randomly chosen from the counties list, using the index call from the random Int
                    Text(countries[correctAnswer])
                        // set colour of teext to white
                        .foregroundColor(.white)
                        // assign a large font title
                        .font(.largeTitle)
                        // assign the bold font weight
                        .fontWeight(.black)
                }
                
                // create a ForEach loop from 0-2 inclusive
                ForEach(0 ..< 3) { number in
                    // create button that calls the flag tapped function
                    Button(action: {
                        // closure flagtapped function with the number parameter
                        self.flagTapped(number)
                    }) { // show image for the countries selected
                        Image(self.countries[number])
                            // set rendering mode
                            .renderingMode(.original)
                            // set a capsule shape on the images
                            .clipShape(Capsule())
                            // set an overlay - outline the images
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            // create a shadow
                            .shadow(color: .black, radius: 2)
                    }
                }
                // set spacer
                Spacer()
            }
            // VStack for the current score
            VStack {
                Spacer()
                Text("Your current score is \(score)")
                    .foregroundColor(.white)
            }
        } // create alert for using the showing score state variable - provides feedback on score, and continue with the game
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your current score is: \(score)"), dismissButton: .default(Text("Continue")) {
                // once alert has been dismissed, continue with the ask question function
                self.askQuestion()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
