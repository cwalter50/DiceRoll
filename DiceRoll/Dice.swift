//
//  Dice.swift
//  DiceRoll
//
//  Created by Christopher Walter on 6/8/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation


//class Dice: ObservableObject {
//    @Published var value: Int
//}
class Die: Identifiable, Comparable, Codable {

    var id = UUID()
    var val: Int = Int.random(in: 1...6)
    var numSides: Int = 6
    
    init ()
    {
        numSides = 6
        val = Int.random(in: 1...6)
    }
    init(numSides: Int)
    {
        self.numSides = numSides
        val = Int.random(in: 1...numSides)
    }
    init(val: Int, numSides: Int)
    {
        self.numSides = numSides
        self.val = val
    }
    func roll()
    {
        self.val = Int.random(in: 1...numSides)
    }
    
    static func < (lhs: Die, rhs: Die) -> Bool {
        return lhs.val < rhs.val
    }
    
    static func == (lhs: Die, rhs: Die) -> Bool {
        return lhs.val == rhs.val
    }
    
}

// this will keep track of each individual roll to display rolls in
class Roll: ObservableObject, Identifiable {
    @Published var dice: [Die] = [Die]()
    
    var id = UUID()
    var numSides: Int = 6
    var numDice: Int = 1
    var sum : Int = 1
    var created: Date = Date()
    
    init(dice: [Die], numSides: Int)
    {
        self.dice = dice
        self.numSides = numSides
        self.numDice = dice.count
//        sum = 0
        updateSum()
        
        created = Date()
    }
    init(dice: [Die], numSides: Int, created: Date) {
        self.dice = dice
        self.numSides = numSides
        self.numDice = dice.count
        sum = 0
        for die in dice
        {
            sum += die.val
        }
        
        self.created = created
    }
    
    func updateSum() {
        sum = 0
        for die in dice
        {
            sum += die.val
        }
    }
}

class Rolls: ObservableObject {
    @Published var rollList = [Roll]()
}
