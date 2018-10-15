//
//  FavCreatureTableViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit



class FavCreatureTableViewController: UITableViewController {
    
    // MARK: - Init
    
    private weak var delegate : SelectedCreaturePreviewDelegate?
    private var selectedCell : LucidTableViewCell?
    private var chosenCreature : Creature?
    private  let allCreatures = LucidCreaturesFactory.getAllCreatures()
    private static let lucidDreamCellHeight =  CGFloat(90.0 * Constants.resizeFactor)
    
    
    public func configure(delegate : SelectedCreaturePreviewDelegate? , chosenCreature : Creature?){
        self.delegate = delegate
        self.chosenCreature = chosenCreature
    }
    

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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavCreatureTableViewController.lucidDreamCellHeight
    }
    
     // MARK: - TableView Cells preparation
    
    private func prepareCellForCreature(_ indexPath : IndexPath) -> UITableViewCell?{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCreature", for: indexPath)
        if let lucidCell =  cell as? LucidTableViewCell, let imageId = allCreatures[indexPath.row].imageIdentifier{
            let title = allCreatures[indexPath.row].name
            let labelSize = lucidCell.getImageViewSize()
            let image = ImageFactory.createImage(from: imageId, count: 1, of: labelSize)
            
            lucidCell.configure(title: title, image: image)
            
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
    
    // MARK: - Actions
    
    @IBAction func DoneFunction(_ sender: UIBarButtonItem) {
        if let chosen = chosenCreature {
             delegate?.creatureIsSelected(chosen)
        }
      
        
        close()
    }
    
    
    @IBAction func CancelFunction(_ sender: UIBarButtonItem) {
        
        close()
    }
    
    func close() {
        self.presentingViewController?.dismiss(animated: true)
    }

}
