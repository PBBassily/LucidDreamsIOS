//
//  CreatureCollectionViewCell.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class CreatureCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var creatureImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                
                creatureImageView.layer.borderWidth = 5
                creatureImageView.layer.borderColor = UIColor.blue.cgColor
            }
            else {
                creatureImageView.layer.borderWidth = 0
            }
        }
    }
}
