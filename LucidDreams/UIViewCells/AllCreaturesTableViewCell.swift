//
//  AllCreaturesTableViewCell.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

protocol CreaturesCollectionViewDelegate : class {
    func creatureIsSelected (_ creature : Creature)
}

class AllCreaturesTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource {

    weak var delegate : CreaturesCollectionViewDelegate?
    var allCreatures = LucidCreaturesFactory.getAllCreatures()
    
     
    @IBOutlet weak var creaturesCollectionView: UICollectionView!
    
    func configureCell() {
        creaturesCollectionView.isUserInteractionEnabled = true
        creaturesCollectionView.allowsSelection = true
        creaturesCollectionView.dataSource = self
        creaturesCollectionView.delegate = self
    }
 
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return allCreatures.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreatureCollectionCell", for: indexPath) as! CreatureCollectionViewCell
        
        cell.creatureImageView.contentMode = .scaleAspectFit
        cell.creatureImageView.image = UIImage(named: allCreatures[indexPath.row].imageIdentifier!)
        
        
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.creatureIsSelected(allCreatures[indexPath.row])
    }
    
    
}
