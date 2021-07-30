//
//  ContentView.swift
//  WeSplit
//
//  Created by Ash Bronca on 26/7/21.
//

import SwiftUI

struct ContentView: View {
    // create variables with two way binding using the @state wrapper
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    // create tip percentage array for options
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // create Double variable for total per person
    var totalPerPerson: Double {
        
        // create variables to convert values to doubles
        let peopleCount = Double(numberOfPeople) ?? 1 // optional
        let tipSelection = Double(tipPercentages[tipPercentage]) // array
        let orderAmount = Double(checkAmount) ?? 0 // optional
        
        // math variables
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // create the total Double variables to convert values to doubles
    var total: Double {
        
        let orderAmount = Double(checkAmount) ?? 0 // optional
        let tipSelection = Double(tipPercentages[tipPercentage]) // array
        
        // math variables
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    // body begins
    var body: some View {
        NavigationView { // creates the naviagtion view - given the navigation title at end of view
            Form { // start the form
                // first section
                Section {
                    TextField("Amount", text: $checkAmount) // create text field with grey text for amount, and a two way binding for the check amount value
                        .keyboardType(.decimalPad) // set keyboard type to allow only numerical input

                    TextField("Number of People", text: $numberOfPeople) // create text field with grey text for amount, and a two way binding for the check amount value
                        .keyboardType(.decimalPad) // set keyboard type to allow only numerical input
                    }
                
                // second section
                Section(header: Text("How much tip do you want to leave?")) { // gives the section a header
                    Picker("Tip percentage", selection: $tipPercentage) { // creates a picker that gives an array of options from tip percentages
                        ForEach(0 ..< tipPercentages.count) { // for each loop that goes from 0 to amount of percentages in array
                            Text("\(self.tipPercentages[$0])%") // closure
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()) // gives the percentage view a horizontal option
                }
            
                // third section
                Section (header: Text("Amount per person")) { // creates a header for the third section
                    Text("$\(totalPerPerson, specifier: "%2.f")") // creates the total amount per person
                }
                
                // fourth section
                Section (header: Text("Total Amount")) { // creates a header for the fourth section
                    Text("$\(total, specifier: "%2.f")") // creates the total amount due
                }
            }
            .navigationBarTitle("WeSplit") // gives navigation view a title
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

