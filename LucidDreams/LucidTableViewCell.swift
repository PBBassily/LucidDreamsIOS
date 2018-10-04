//
//  LucidTableViewCell.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class LucidTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var lucidLabel: UILabel!
    @IBOutlet weak var lucidImageView: UIImageView!
    
    
    
    func addImages(for name:String, with number:Int){
        
        
        //let size = CGSize(width: lucidImageView.frame.width, height: lucidImageView.frame.height )
        let image = UIImage(named: name)
        let resizeConstant = CGFloat(Double(number+1)/2)
        //let imageNewSize = CGSize(width: (image?.size.width)! * resizeConstant, height: (image?.size.height)! * resizeConstant) // the mgaic formula :D
        let imageNewSize =  (image?.size)!
        let imaginaryImageViewHeight = (image?.size.height)! * resizeConstant
        let imaginaryImageViewWidth = (lucidImageView.frame.width * imaginaryImageViewHeight ) / lucidImageView.frame.height
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imaginaryImageViewWidth, height: imaginaryImageViewHeight), false, 0.0)
     
        
        
        //var x = number == 1 ? CGFloat(0) : imageNewWidth / CGFloat(2)
        //var y = number == 1 ? CGFloat(0) : imageNewHeight / CGFloat(2)
        var x = (imaginaryImageViewWidth - imaginaryImageViewHeight)/CGFloat(2)
        var y = CGFloat(0)
        for _ in 0..<number {
            let image = UIImage(named: name)
            image!.draw(in: CGRect(x: x, y: y, width: imageNewSize.width , height: imageNewSize.height))
            x  = x + imaginaryImageViewWidth / CGFloat(2*number)
            y = y + imaginaryImageViewHeight /  CGFloat(2*number)
            
        }

        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        lucidImageView.image = newImage
       lucidImageView.contentMode = .scaleAspectFit
        
    }
    
}
