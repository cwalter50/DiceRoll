//
//  Settings.swift
//  DiceRoll
//
//  Created by Christopher Walter on 6/10/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation

struct Settings: Codable {
    var numSides: Int = 6
    var numDice: Int = 1
    
    
    init() {
        // grab data from user defaults if its available. Otherwise create new data
        if let data = UserDefaults.standard.data(forKey: "Settings")
        {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Settings.self, from: data) {
                self = decoded
                return
            }
        }
        
        // if we don't find data. create default data
        numSides = 6
        numDice = 1
    }

    
    func save() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Settings")
            return
        }else {
            print("Error in saving Settings")
        }
    }
}
