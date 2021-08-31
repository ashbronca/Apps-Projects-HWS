//
//  ContentView.swift
//  Temp Converter
//
//  Created by Ash Bronca on 31/8/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputTemp = "" // create string variable to input temp
    @State var inputUnit = 0 // set default unit to C
    @State var outputUnit = 2 // set default unit to K

    let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin] // array of temperature units, called from unit temperature - I did not need to use strings here, as the value is brought in from UnitTemperature
    
    // create a function using the key value pairsfor temp, input unit, and output unit - assign the unit temp selected - return a string
    func convert(temperature: String, from inputUnit: UnitTemperature, to outputUnit: UnitTemperature) -> String? {
        let inputFormatter = NumberFormatter() // declare the input formatter from number formatter
        guard let value = inputFormatter.number(from: temperature) else { return nil } // optional to check the input temp - else return nothing

        let inputTemp = Measurement(value: value.doubleValue, unit: inputUnit) // declare the input temp measurement value - converted to a double - using the input unit selected
        let outputTemp = inputTemp.converted(to: outputUnit) // declaure the output temp as input temp converted to output unit

        let outputformatter = MeasurementFormatter() // ensure the values have the correct symbol for the unit selected
        outputformatter.unitOptions = .providedUnit
        return outputformatter.string(from: outputTemp) // return the output converted temp
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your number to convert", text: $inputTemp) // create a text field to show the user what to input
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("What unit would you like to convert from?")) { // show user text header
                    Picker("Input Unit", selection: $inputUnit) { // create picker from the input unit variable (two way binding using the @state)
                        ForEach(0 ..< units.count) { // create a foreach loop to iterate from 0 to number of units in array
                            Text("\(self.units[$0].symbol)") // print text value for input temp converter
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()) // picker style selection - horizontal picker
                }

                Section(header: Text("What unit would you like to convert to?")) { // show user text header
                    Picker("Output Unit", selection: $outputUnit) { // create picker from the output unit variable (two way binding using the @state)
                        ForEach(0 ..< units.count) { // create a foreach loop to iterate from 0 to number of units in array
                            Text("\(self.units[$0].symbol)") // print text value for output temo converter
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()) // picker style selection - horizontal picker
                }

                Section(header: Text("Converted Temperature")) { // print header for output
                    Text(convert(temperature: inputTemp, from: units[inputUnit],
                                to: units[outputUnit]) ?? "Invalid input") // print text for output temp - text value of invalid input
                }

            }
            .navigationBarTitle("Temperature Converter") // add a title
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
