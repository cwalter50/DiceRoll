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
    @FetchRequest(entity: CDRoll.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CDRoll.sum, ascending: true)]) var cdRoll: FetchedResults<CDRoll>
    

    var body: some View {
        NavigationView {
            List {
                ForEach(rolls.rollList) {
                    roll in
                    Text("\(roll.sum)")
                }
            }
        .navigationBarTitle("Results")
        .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        
        // cdRolls are grabbed in the fetchResults at the top of this struct. Place them as type Roll into the rolls...
        rolls.rollList = cdRoll.map {
            $0.roll
        }
               
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
