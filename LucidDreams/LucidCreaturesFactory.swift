//
//  lucidImagesFactory.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation


class LucidCreaturesFactory {
    
    private static let nameMapping : [String:String] = [
        "crusty":"Crusty",
        "dragon":"Dragon",
        "unicorn-pink":"Pink Unicorn",
        "unicorn-white":"White Unicorn",
        "unicorn-yellow":"Yellow Unicorn",
        "shark":"Shark"
    ]
    
    static func getDefaultCreature() -> Creature {
        
        return createCreature(with: "unicorn-white")
    }
    
    static func createCreature(with assetName : String) -> Creature {
        
       return Creature(name: nameMapping[assetName], imageIdentifier: assetName )
    }
    
    
    static func getAllCreatures() -> [Creature] {
        
        return nameMapping.map({ (key, _ ) in
            return createCreature(with: key)
        })
        
    }
    
}
