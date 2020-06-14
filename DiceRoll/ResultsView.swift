//
//  ResultsView.swift
//  DiceRoll
//
//  Created by Christopher Walter on 6/7/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var rolls = Rolls()
    
    // CoreData Stuff
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CDRoll.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CDRoll.created, ascending: false)]) var cdRoll: FetchedResults<CDRoll>
    

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Num Rolls: \(rolls.rollList.count)")
                    Spacer()
                    Text("Average: \(rolls.averageString)")
                }
                .font(.headline)
                .foregroundColor(Color.green)
                .padding()
                
                
                
                List {
                    ForEach(rolls.rollList) {
                        roll in
                        HStack {
                            Text("Total: \(roll.sum)")
                                .font(.title)
                            Spacer()
                            ForEach(roll.dice) {
                                die in
                                Image(systemName: "\(die.val).square")
                            }
                        }
                        
                    }
                .onDelete(perform: removeRoll)
                }
            }
            
        .navigationBarTitle("Results")
        .onAppear(perform: loadData)
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.clearAllRolls()
            }) {
                Text("Clear Rolls")
            })
        }
    }
    
    func loadData() {
        
        // cdRolls are grabbed in the fetchResults at the top of this struct. Place them as type Roll into the rolls...
        rolls.rollList = cdRoll.map {
            $0.roll
        }
    }
    
    func removeRoll(at offsets: IndexSet) {
        for index in offsets {
            let roll = cdRoll[index]
            moc.delete(roll)
        }
        
        do {
            try moc.save()
        } catch {
            // handle the Core Data error
            print("error in deleting")
        }
        loadData()
    }
    func clearAllRolls() {
        for roll in cdRoll {
            moc.delete(roll)
        }
        
        do {
             try moc.save()
         } catch {
             // handle the Core Data error
             print("error in deleting")
         }
        
        // reload the data
        loadData()
    }

}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
