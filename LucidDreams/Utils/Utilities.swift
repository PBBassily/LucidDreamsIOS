//
//  Utilities.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/14/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation
import UIKit

class Constants {
     private static  var resizeFactor : Double  {
        get {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 1.5
            }
            return 1.0
        }
        
    }
    static let  dreamTableViewCellsHeight   = [150.0, 60.0, 60.0, 200.0].map({CGFloat($0 * resizeFactor)})
    
    
    static let creatureCollectionViewCellSize = CGSize(width: 90.0 * resizeFactor, height: 90.0 * resizeFactor)
    
    static let lucidDreamCellHeight =  CGFloat(90.0 * resizeFactor)
}
