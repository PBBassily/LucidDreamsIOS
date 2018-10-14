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
    
    var dreamPreviewCell : LucidTableViewCell?
    
    var creaturesCVDelegate = CreaturesCollectionVCDelegate()
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell : UITableViewCell
        
        if indexPath.section == 0 {
            
            cell = prepareDreamPreviewCell(at : indexPath)
            
        } else if indexPath.section == 1 {
            
            cell = prepareCellForInput(at : indexPath, content: "\((mainDream?.title)!)", numbersOnly : false, selector: #selector(descriptionTextDidChange))
            
        } else if indexPath.section == 2  {
            
            cell = prepareCellForInput(at: indexPath, content: "\((mainDream?.number)!)", numbersOnly: true, selector:  #selector(countTextDidChange))
            
        } else {
            cell = prepareCellForAllCreatures(at: indexPath)
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0..<4 : return CGFloat(Constants.dreamTableViewCellsHeight[indexPath.section])
        default : return CGFloat(0)
        }
    }
    
    //MARK: - Cells preparation
    
    private func prepareDreamPreviewCell(at indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath)
        
        if let lucidCell = cell as? LucidTableViewCell {
            lucidCell.lucidLabel.text = mainDream?.title
            lucidCell.lucidImageView.image = UIImage(named: mainDream?.creature.imageIdentifier ?? "" )
            dreamPreviewCell = lucidCell
            
        }
        return cell
    }
    
    private func prepareCellForInput(at indexPath: IndexPath,content : String, numbersOnly : Bool, selector: Selector) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath)
        
        if let inputCell = cell as? InputTableViewCell {
            
            inputCell.inputTextField.text = content
            
            inputCell.inputTextField.addTarget(self, action: selector, for: UIControlEvents.editingChanged)
            
            inputCell.inputTextField.keyboardType =  numbersOnly ? .asciiCapableNumberPad : .default
            
        }
        
        return cell
    }
    
    private func prepareCellForAllCreatures(at indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectViewCell", for: indexPath)
        if let collectionViewCell = cell as? AllCreaturesTableViewCell{
            creaturesCVDelegate.delegate = self
            creaturesCVDelegate.creaturesCollectionView = collectionViewCell.creaturesCollectionView
        }
        return cell
    }
    
    
    //MARK: - Input textfields listeners
    
    
    private func animateChange(text: String ) {
        UIView.transition(
            with : (self.dreamPreviewCell?.lucidLabel)!,
            duration: 0.5,
            options: UIViewAnimationOptions.transitionCrossDissolve,
            animations: {
                (self.dreamPreviewCell?.lucidLabel)!.text = text
        },
            completion: nil)
    }
    
    @objc func descriptionTextDidChange( textField: UITextField) {
        
        mainDream?.title=textField.text!
        
        animateChange(text: textField.text!)
        
        
    }
    
    @objc func countTextDidChange( textField: UITextField) {
        
        mainDream?.number = Int(textField.text!) ?? 1
    }
    
    
    // MARK: - Delegation
    
    func creatureIsSelected(_ creature : Creature) {
        mainDream?.creature = creature
        tableView.reloadData()
    }
    
    
}
