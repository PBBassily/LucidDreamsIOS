//
//  CreaturesCollectionViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/14/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CreatureCollectionCell"


protocol SelectedCreaturePreviewDelegate: class {
    
    func  creatureIsSelected(_ creature : Creature)
}
class CreaturesCollectionVCDelegate: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var allCreatures = LucidCreaturesFactory.getAllCreatures()
    weak var delegate : SelectedCreaturePreviewDelegate?

    var creaturesCollectionView: UICollectionView? {
        didSet{
            creaturesCollectionView?.allowsSelection = true
            creaturesCollectionView?.dataSource = self
            creaturesCollectionView?.delegate = self
        }
    }
    
    // MARK: UICollectionViewDataSource



 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return allCreatures.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreatureCollectionViewCell
        
        cell.creatureImageView.contentMode = .scaleAspectFit
        cell.creatureImageView.image = UIImage(named: allCreatures[indexPath.row].imageIdentifier!)
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.creatureIsSelected(allCreatures[indexPath.row])
    }


}
