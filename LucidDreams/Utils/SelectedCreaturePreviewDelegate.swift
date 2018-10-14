//
//  SelectedCreaturePreviewDelegate.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/14/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation

protocol SelectedCreaturePreviewDelegate: class {
    
/**
   
     Makes it easier for view controllers to know whicj creature is chosen in subviews to be previewed
     delegate must implement this function and customise the action following the selection
     
     
 */
     func  creatureIsSelected(_ creature : Creature)
}
