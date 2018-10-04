//
//  LucidDreamsFactory.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/3/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation

struct LucidDreamsFactory {
    
    static func getDeafultDreamsBatch() -> [Dream]{
        let uincorn = LucidCreaturesFactory.getDefaultCreature()
        
        return
            [Dream(number: 1, creature: uincorn, title: "Dream 1"),
        Dream(number: 2, creature: uincorn, title: "Dream 2"),
        Dream(number: 3, creature: uincorn, title: "Dream 3")
        ]
    }
    
    
}
