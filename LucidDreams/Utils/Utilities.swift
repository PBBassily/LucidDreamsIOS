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
     public static  var resizeFactor : Double  {
        get {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 1.5
            }
            return 1.0
        }
        
    }
   
    
    
    
    
    
}
