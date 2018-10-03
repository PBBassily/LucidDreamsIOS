//
//  LucidTableViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit



class LucidTableViewController: UITableViewController, FavCreatureTableViewDelegate{
    
    
    //MARK: - datasource init
    var favCreature = LucidCreaturesFactory.getDefaultCreature()
    var dreams = LucidDreamsFactory.getDeafultDreamsBatch()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 : return 1
        case 1 : return dreams.count
        default : return 0
        }
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell : LucidTableViewCell
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "FavCreatureCell", for: indexPath) as! LucidTableViewCell
            cell.lucidLabel.text = favCreature.name
            cell.lucidImageView.contentMode = .scaleAspectFit
            cell.lucidImageView.image = UIImage(named: favCreature.imageIdentifier!)
            
            
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath) as! LucidTableViewCell
            let dream = dreams[indexPath.row]
            cell.lucidLabel.text = dream.title
           // cell.lucidImageView.image = UIImage(named: dream.creature.imageIdentifier!)
            cell.addImages(for: dream.creature.imageIdentifier! , with: dream.number)
            cell.lucidImageView.contentMode = .scaleAspectFit
            
            cell.accessoryType  = .disclosureIndicator
        }
        
        
        
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 : return "FAVORITE CREATURE"
        case 1 : return "DREAMS"
        default : return nil
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    //MARK: - Delegation
    
    func updateCreature(_ creature: Creature)  {
        favCreature = creature
        tableView.reloadData()
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "ShowFavTableView" {
            if let navcon = segue.destination as? UINavigationController, let favCreatureTableViewController = navcon.childViewControllers[0] as? FavCreatureTableViewController {
                favCreatureTableViewController.delegate = self
                favCreatureTableViewController.chosenCreature = favCreature
            }
        }
        else if segue.identifier == "DreamSegueing", let cell  = sender as? LucidTableViewCell, let indexPath = tableView.indexPath(for: cell) {
            if let dreamTableViewController  = segue.destination as? DreamTableViewController {
                
                dreamTableViewController.mainDream = dreams[indexPath.row]
            }
        }
     }
    
    
}
