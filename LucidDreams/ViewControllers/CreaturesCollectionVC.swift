//
//  CreaturesCollectionViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/14/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CreatureCollectionCell"


class CreaturesCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Init
    
    private var allCreatures = LucidCreaturesFactory.getAllCreatures()
    private weak var delegate : SelectedCreaturePreviewDelegate?
    private static let creatureCollectionViewCellSize = CGSize(width: 90.0 * Constants.resizeFactor, height: 90.0 * Constants.resizeFactor)
    
    
    
    private var creaturesCollectionView: UICollectionView? {
        didSet{
            creaturesCollectionView?.dataSource = self
            creaturesCollectionView?.delegate = self
        }
    }
    public func configure(creaturesCollectionView: UICollectionView?, delegate: SelectedCreaturePreviewDelegate?) {
        
        self.creaturesCollectionView = creaturesCollectionView
        self.delegate = delegate
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCreatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let creatureCollectionCell = cell as? CreatureCollectionViewCell{
        let image = UIImage(named: allCreatures[indexPath.row].imageIdentifier!)
            creatureCollectionCell.configure(image: image)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.creatureIsSelected(allCreatures[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CreaturesCollectionVC.creatureCollectionViewCellSize
    }
    
}
