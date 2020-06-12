//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Christopher Walter on 6/10/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    // this is so we can dismiss the modal view
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var settings: Settings
    @State private var numSides = 6
    @State private var numDice = 1
    
    var sideOptions = [2, 4, 5, 6, 8, 10, 12, 15, 20, 50]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Number of Sides").font(.headline)) {
                    Picker("", selection: $numSides) {
                        ForEach(0 ..< sideOptions.count) {
                            Text("\(self.sideOptions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Number of Dice").font(.headline)) {
                    Stepper("\(numDice)", value: $numDice, in: 1...3)

                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button(action: {
                //update setting values and save
                self.settings.numDice = self.numDice
                self.settings.numSides = self.sideOptions[self.numSides]
                
                // savce to userDefaults
                self.settings.save()
                
                // dismiss
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
            })
            
        }
        .onAppear(perform: setSettings)
    }
    
    func setSettings()
    {
        numDice = settings.numDice
//        numSides = settings.numSides
        numSides = sideOptions.firstIndex(of: settings.numSides) ?? 3
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: .constant(Settings()))
    }
}
