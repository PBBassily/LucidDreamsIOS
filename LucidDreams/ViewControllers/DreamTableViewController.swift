//
//  DreamTableViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class DreamTableViewController: UITableViewController, SelectedCreaturePreviewDelegate{
    
    
    private var mainDream : Dream?
    
    private var dreamPreviewCell : LucidTableViewCell?
    
    private var creaturesCVDelegate = CreaturesCollectionVC()
    
    private  static let  dreamTableViewCellsHeight   = [150.0, 60.0, 60.0, 200.0].map({CGFloat($0 * Constants.resizeFactor)})
    
     // MARK: - Config
    
    public func config(mainDream : Dream?){
        
        self.mainDream = mainDream
        
    }
    
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
        
        if mainDream == nil {
            return UITableViewCell()
        }
        
        let cell : UITableViewCell
        
        if indexPath.section == 0 {
            
            cell = prepareDreamPreviewCell(at : indexPath)
            
        } else if indexPath.section == 1 {
            
            cell = prepareCellForInput(at : indexPath, content: mainDream!.title, numbersOnly : false, selector: #selector(descriptionTextDidChange))
            
        } else if indexPath.section == 2  {
            
            cell = prepareCellForInput(at: indexPath, content: "\(mainDream!.number)", numbersOnly: true, selector:  #selector(countTextDidChange))
            
        } else {
            cell = prepareCellForAllCreatures(at: indexPath)
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0..<4 : return DreamTableViewController.dreamTableViewCellsHeight[indexPath.section]
        default : return CGFloat(0)
        }
    }
    
    //MARK: - Cells preparation
    
    private func prepareDreamPreviewCell(at indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath)
        
        if let lucidCell = cell as? LucidTableViewCell {
            let title = mainDream?.title
            let image = UIImage(named: mainDream?.creature?.imageIdentifier ?? "" )
            lucidCell.configure(title: title, image: image)
            dreamPreviewCell = lucidCell
            
        }
        return cell
    }
    
    private func prepareCellForInput(at indexPath: IndexPath,content : String?, numbersOnly : Bool, selector: Selector) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath)
        
        if let inputCell = cell as? InputTableViewCell {
            
            inputCell.configure(text: content)
            
            inputCell.addEditingChangedListener(target: self,selector: selector)
            
            if numbersOnly {
                inputCell.setNumberPadOnly()
            }
            
        }
        return cell
    }
    
    private func prepareCellForAllCreatures(at indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectViewCell", for: indexPath)
        if let collectionViewCell = cell as? AllCreaturesTableViewCell{
            creaturesCVDelegate.configure(creaturesCollectionView: collectionViewCell.creaturesCollectionView, delegate: self)
           
        }
        return cell
    }
    
    
    //MARK: - Input textfields listeners
    
    
    @objc func descriptionTextDidChange( textField: UITextField) {
        if let text = textField.text {
            mainDream?.title = text
            dreamPreviewCell?.animateChange(text: text)
        }
      
        
        
    }
    
    @objc func countTextDidChange( textField: UITextField) {
        
        mainDream?.number = Int(textField.text ?? "") ?? 1
    }
    
    
    // MARK: - Delegation
    
    func creatureIsSelected(_ creature : Creature) {
        mainDream?.creature = creature
        tableView.reloadData()
    }
    
    
}
