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
        
        
//        let topImage = UIImage(named: "unicorn-white")
//        let bottomImage = UIImage(named: "unicorn-white")
//
//        let size = CGSize(width: topImage!.size.width, height: topImage!.size.height + bottomImage!.size.height)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//
//        topImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: topImage!.size.height))
//        bottomImage!.draw(in: CGRect(x: 0, y: topImage!.size.height, width: size.width, height: bottomImage!.size.height)
        
        
        let size = CGSize(width: lucidImageView.frame.width, height: lucidImageView.frame.height )
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        for _ in 0..<number {
            let image = UIImage(named: name)
            image!.draw(in: CGRect(x: x, y: y, width: image!.size.width / CGFloat(number) , height: image!.size.height / CGFloat(number)))
            x  = x + size.width / CGFloat(number)
            y = y + size.height / CGFloat(number)
        }

        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        lucidImageView.image = newImage
        lucidImageView.contentMode = . scaleAspectFit
        
    }
    
}
