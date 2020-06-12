//
//  CDRoll+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Christopher Walter on 6/11/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//
//

import Foundation
import CoreData


extension CDRoll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRoll> {
        return NSFetchRequest<CDRoll>(entityName: "CDRoll")
    }

    @NSManaged public var created: Date?
    @NSManaged public var sum: Int16
    @NSManaged public var numSides: Int16
    @NSManaged public var diceValues: [NSNumber]?
    
    var wrappedCreated: Date {
        return created ?? Date()
    }
    
    var wrappedDiceValues: [Int] {
        var result: [Int] = [Int]()
        
        if let values = diceValues {
            for val in values {
                result.append(Int(truncating: val))
            }
        }
        return result
    }
        
    var roll: Roll {
        
        var dice = [Die]()
        let sides = Int(numSides)
        
        for val in wrappedDiceValues {
            dice.append(Die(val: val, numSides: sides))
        }
        
        return Roll(dice: dice, numSides: sides, created: wrappedCreated)
    }
        
    func setProperties(from roll: Roll) {
        
        numSides = Int16(roll.numSides)
        sum = Int16(roll.sum)
        
        var diceVals: [NSNumber] = [NSNumber]()
        for die in roll.dice {
            diceVals.append(NSNumber(value: die.val))
        }
        
        diceValues = diceVals
        created = roll.created
        
    }


}
