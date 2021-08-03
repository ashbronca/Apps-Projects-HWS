//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ash Bronca on 2/8/21.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String)-> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    
    @State private var useRedText = true
    
    var body: some View {
        Color.blue
            .frame(width: 300, height: 300)
            .watermarked(with: "Hacking With Swift")
        
        Text("Hello World")
            .modifier(Titles())
    }
}

struct Titles: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)    }
}

extension View {
    func titleStyled() -> some View {
        self.modifier(Titles())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
