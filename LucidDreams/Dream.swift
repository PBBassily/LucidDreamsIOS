//
//  Dream.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/3/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation

class Dream {
    var number : Int
    var creature : Creature
    var title : String
    
    init(number : Int , creature : Creature, title: String) {
        
        self.number = number
        self.creature = creature
        self.title  = title
        
    }
}
