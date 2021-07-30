//
//  ContentView.swift
//  Unit Converter
//
//  Created by Ash Bronca on 29/7/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputText = ""
    @State var inputUnit = 0
    @State var outputUnit = 1

    let units = ["Celsius", "Farenheit"]
    
    // convert user input to unit measurement
    
    var finalNumbers: Double {
        
        let inputNumber = Double(inputText) ?? 1
        let inputUnitSelected = Double(units[inputUnit])
        let Celsius = (inputNumber * 1.8) + 32
        let outputUnitSelection = Double(units[outputUnit])
        let newNumber = Celsius / outputUnitSelection!
        
        return newNumber
        
        
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your number to convert", text: $inputText)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("What unit would you like to convert from?")) {
                    Picker("Temperature Unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("What unit would you like to convert to?")) {
                    Picker("Temperature Unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Converted Temperature")) {
                    Text("$\(outputUnit, specifier: "%2.f")")
                }

            }
            .navigationBarTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
