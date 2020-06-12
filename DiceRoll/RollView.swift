//
//  RollView.swift
//  DiceRoll
//
//  Created by Christopher Walter on 6/7/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .padding(.horizontal, 30)
        .padding()
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(40)
  }
}

struct RollView: View {
    
    @EnvironmentObject var roll: Roll
//    @State var dice: [Die] = [Die]()
    @State var numDice: Int = 1
    @State var numSides: Int = 6
    
    @State var showSettings = false
    
    @State var settings: Settings
    
    // CoreData Stuff
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Total: \(roll.sum)")
                    .font(.largeTitle)
                HStack {
                    ForEach(roll.dice) {
                        die in
                        GeometryReader { geo in
                            Image(systemName: "\(die.val).square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: (geo.size.width-20)/CGFloat(self.numDice))
                        }
                    }
                }
                Spacer()
                Button(action: {
                    self.rollDice()
                }) {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text("Roll")
                            .fontWeight(.semibold)
                    }
                    .font(.title)
                }
                .buttonStyle(MyButtonStyle())
                Spacer()
                
            }
            .navigationBarTitle("Roll Dice")
            .navigationBarItems(leading: Button(action: {
                self.showSettings = true
            }) {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            })
                .sheet(isPresented: $showSettings, onDismiss: reloadDice) {
                    SettingsView(settings: self.$settings)
            }
            .onAppear(perform: reloadDice)
            
        }
        
    }
    
    func rollDice()
    {
        roll.dice.removeAll()
        for _ in 1...settings.numDice {
            roll.dice.append(Die(numSides: settings.numSides))
        }
        roll.created = Date() // hopeing this will create a unique value in coreData
        roll.updateSum()
        saveDataToCoreData(roll)
        
    }
    
    func reloadDice()
    {
        roll.dice.removeAll()
        for _ in 1...settings.numDice {
            roll.dice.append(Die(numSides: settings.numSides))
        }
    }
    
    func saveDataToCoreData(_ data: Roll) {
        let cdRoll = CDRoll(context: moc)
        
        cdRoll.setProperties(from: data)
        
        try! moc.save()
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView(settings: Settings())
    }
}
