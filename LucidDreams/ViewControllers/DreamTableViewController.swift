//
//  DreamTableViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class DreamTableViewController: UITableViewController, SelectedCreaturePreviewDelegate{
   
    
    var mainDream : Dream?
    var creatureCollectionView: UICollectionView?
    
    var dreamPreviewCell : LucidTableViewCell?
    var dreamDecriptionCell : InputTableViewCell?
    var dreamCountCell : InputTableViewCell?
    
    var creaturesCollectionViewContoller = CreaturesCollectionVCDelegate()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return ""
        case 1: return "Description"
        case 2: return "Number of Creatures"
        case 3: return "Creatures"
        default : return ""
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell : UITableViewCell
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath)
            let lucidCell = cell as! LucidTableViewCell
            lucidCell.lucidLabel.text = mainDream?.title
            lucidCell.lucidImageView.contentMode = .scaleAspectFit
            lucidCell.lucidImageView.image = UIImage(named: mainDream?.creature.imageIdentifier ?? "" )
            
           dreamPreviewCell = lucidCell
            
        }
        
        else if indexPath.section == 1{
           cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath)
            let inputCell = cell as! InputTableViewCell
            
            inputCell.inputTextField.text = "\((mainDream?.title)!)"
            //inputCell.inputTextField.fadeTransition(0.4)
            inputCell.inputTextField.addTarget(self, action: #selector(descriptionTextDidChange), for: UIControlEvents.editingChanged)
            
            dreamDecriptionCell = inputCell
           
        } else if indexPath.section == 2  {
            
            
            cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath)
            let inputCell = cell as! InputTableViewCell
                inputCell.inputTextField.text = "\((mainDream?.number)!)"
                inputCell.inputTextField.keyboardType = .asciiCapableNumberPad
                inputCell.inputTextField.addTarget(self, action: #selector(countTextDidChange), for: UIControlEvents.editingChanged)
                dreamCountCell = inputCell
            }
            
       
        else{
           cell = tableView.dequeueReusableCell(withIdentifier: "CollectViewCell", for: indexPath)
            let collectionViewCell = cell as! AllCreaturesTableViewCell
           creaturesCollectionViewContoller.delegate = self
            creaturesCollectionViewContoller.creaturesCollectionView = collectionViewCell.creaturesCollectionView
            
        }
        
        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 : return CGFloat(150)
        case 1,2 : return CGFloat(60)
        case 3 : return CGFloat(190)
        default : return CGFloat(0)
        }
    }
    
    //MARK: - CollectionView
    
    
    
    //MARK: - Actions

    
    @objc func descriptionTextDidChange( textField: UITextField) {
        UIView.transition(
            with : (self.dreamPreviewCell?.lucidLabel)!,
         duration: 0.5,
         options: UIViewAnimationOptions.transitionCrossDissolve,
         animations: {
            (self.dreamPreviewCell?.lucidLabel)!.text = textField.text
        },
         completion: nil)
        
        dreamPreviewCell?.lucidLabel.text = textField.text!
        mainDream?.title=textField.text!
        
    }
    
    @objc func countTextDidChange( textField: UITextField) {
        
        mainDream?.number = Int(textField.text!) ?? 1
    }
    
    
    // MARK: - Delegation
    
    func creatureIsSelected(_ creature : Creature) {
        mainDream?.creature = creature
        //dreamPreviewCell?.imageView?.image = UIImage(named: creature.imageIdentifier!)
        tableView.reloadData()
    }
    

}
