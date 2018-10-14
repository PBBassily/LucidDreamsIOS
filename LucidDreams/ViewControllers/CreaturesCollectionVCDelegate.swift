//
//  CreaturesCollectionViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/14/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CreatureCollectionCell"


class CreaturesCollectionVCDelegate: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var allCreatures = LucidCreaturesFactory.getAllCreatures()
    weak var delegate : SelectedCreaturePreviewDelegate?
    
    var creaturesCollectionView: UICollectionView? {
        didSet{
            creaturesCollectionView?.dataSource = self
            creaturesCollectionView?.delegate = self
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCreatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreatureCollectionViewCell
        let image = UIImage(named: allCreatures[indexPath.row].imageIdentifier!)
        cell.configure(image: image!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.creatureIsSelected(allCreatures[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.creatureCollectionViewCellSize
    }
    
}
