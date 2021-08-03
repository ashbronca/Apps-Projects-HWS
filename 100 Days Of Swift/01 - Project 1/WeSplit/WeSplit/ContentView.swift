//
//  ContentView.swift
//  WeSplit
//
//  Created by Ash Bronca on 26/7/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 4
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // create Double variable for total per person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) + 2
        let tipSelection = Double(tipPercentages[tipPercentage]) // array
        let orderAmount = Double(checkAmount) ?? 0 // optional
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Text("Total: $\(self.totalPerPerson)")
                        .foregroundColor(tipPercentage == 4 ? Color.red : Color.black)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

