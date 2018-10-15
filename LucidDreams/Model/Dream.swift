//
//  Dream.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/3/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation

class Dream : NSCopying{
    
    
    var number : Int
    var creature : Creature?
    var title : String
    
    init(number : Int? , creature : Creature?, title: String?) {
        
        self.number = number ?? 1
        self.creature = creature 
        self.title  = title ?? ""
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let dreamCopy = Dream(number: number, creature: creature, title: title+" (copy)")
        return dreamCopy
    }
}
