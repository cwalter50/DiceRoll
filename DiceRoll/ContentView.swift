//
//  ContentView.swift
//  DiceRoll
//
//  Created by Christopher Walter on 6/7/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var roll: Roll = Roll(dice: [Die()], numSides: 6)
    
    @State var showSettings = false
    @State private var settings = Settings() // this will load settings from userDefaults
    
    var body: some View {
        TabView {
            RollView(settings: settings)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            ResultsView()
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ResultsView()
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            ResultsView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }
        .environmentObject(roll)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
