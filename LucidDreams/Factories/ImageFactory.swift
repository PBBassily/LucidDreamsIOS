//
//  ImageFactory.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/11/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation
import UIKit
class ImageFactory {
    
    public static func createImage(from imageIdentifer :String?, count number : Int, of size: CGSize) -> UIImage? {
        
        if imageIdentifer == nil{
            return nil
        }
        
        let image = UIImage(named: imageIdentifer!)
        let resizeConstant = CGFloat(Double(number+2)/3)
        let imageNewSize =  (image?.size)!
        let imaginaryImageViewHeight = (image?.size.height)! * resizeConstant
        let imaginaryImageViewWidth = (size.width * imaginaryImageViewHeight ) / size.height
        
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imaginaryImageViewWidth, height: imaginaryImageViewHeight), false, 0.0)
        
        
        var x = (imaginaryImageViewWidth - imaginaryImageViewHeight)/CGFloat(2)
        var y = CGFloat(0)
        
        for _ in 0..<number {
            let image = UIImage(named: imageIdentifer!)
            image!.draw(in: CGRect(x: x, y: y, width: imageNewSize.width , height: imageNewSize.height))
            x  = x + imaginaryImageViewWidth / CGFloat(2*number)
            y = y + (image?.size.height)! /  CGFloat(3)
            
        }
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
}
