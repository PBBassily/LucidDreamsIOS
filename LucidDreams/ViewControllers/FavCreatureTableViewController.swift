//
//  FavCreatureTableViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit


protocol FavCreatureTableViewDelegate : class {
    func updateCreature(_ creature : Creature)
}

class FavCreatureTableViewController: UITableViewController {
    
    weak var delegate : FavCreatureTableViewDelegate?
    var selectedCell : LucidTableViewCell?
    var chosenCreature : Creature?
    let allCreatures = LucidCreaturesFactory.getAllCreatures()
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return allCreatures.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       

        return prepareCellForCreature(indexPath) ?? UITableViewCell()
    }
    
    private func prepareCellForCreature(_ indexPath : IndexPath) -> UITableViewCell?{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCreature", for: indexPath)
        if let lucidCell =  cell as? LucidTableViewCell {
            lucidCell.lucidLabel.text = allCreatures[indexPath.row].name
            let imageIdentifier = allCreatures[indexPath.row].imageIdentifier
            lucidCell.lucidImageView.contentMode = .scaleAspectFit
            lucidCell.lucidImageView.image = UIImage(named: imageIdentifier!)
            
            if chosenCreature == allCreatures[indexPath.row] {
                lucidCell.accessoryType = .checkmark
                selectedCell = lucidCell
            }
            
            return cell
        }
        return nil
    }
    
    // MARK: - Table view selection
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell?.accessoryType = .none
        selectedCell = tableView.cellForRow(at: indexPath) as? LucidTableViewCell
        selectedCell?.accessoryType = .checkmark
        selectedCell?.setSelected(false, animated: true)
        chosenCreature = allCreatures[indexPath.row]
    }
    
   
    func close() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    // MARK: - Actions
    
    @IBAction func DoneFunction(_ sender: UIBarButtonItem) {
        
       delegate?.updateCreature(chosenCreature!)
        
        close()
    }
    
    
    @IBAction func CancelFunction(_ sender: UIBarButtonItem) {
        
        close()
    }
  

    

}
