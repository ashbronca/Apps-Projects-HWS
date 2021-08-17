//
//  ContentView.swift
//  Word Scramble
//
//  Created by Ash Bronca on 12/8/21.
//

import SwiftUI

struct ContentView: View {
    let people = ["Ash", "Rach", "Dan", "Nate"]
    
    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }
        .listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
