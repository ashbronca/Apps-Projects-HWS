//
//  ContentView.swift
//  Project 4
//
//  Created by Ash Bronca on 9/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your recommended bed time is...")) {
                    Text(calculateBedtime())
                        .font(.largeTitle)
                }
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                    }
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                        
                    }
                }
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker(selection: $coffeeAmount, label: Text("Number of cups")) {
                        ForEach(0...20, id: \.self) { // "id: \.self" tells swiftui that each item in the array is unique. The \.self tells us that we are going to reference the coffee amount variable
                            Text("\($0)") // cycle through the foreach loop and print the number of cups 0...20
                        }
                    }
                }
            }
            .frame(height: 1100)
            .padding(.top, 20.0)
        }
    }
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            return formatter.string(from: sleepTime)
                        
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
