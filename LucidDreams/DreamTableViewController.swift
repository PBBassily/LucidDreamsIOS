//
//  DreamTableViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class DreamTableViewController: UITableViewController, UICollectionViewDelegate {

    
    var creatureCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
      
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
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
        case 4: return "Description"
        default : return ""
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell : UITableViewCell
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath)
            let lucidCell = cell as! LucidTableViewCell
            lucidCell.lucidLabel.text = "Dream"
            lucidCell.lucidImageView.contentMode = .scaleAspectFit
            lucidCell.lucidImageView.image = UIImage(named: "shark")
            
        }
        
        else if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 4 {
           cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath)
            if indexPath.section == 2 {
                let inputCell = cell as! InputTableViewCell
                inputCell.inputTextField.keyboardType = .asciiCapableNumberPad
            }
        }
        else {
           cell = tableView.dequeueReusableCell(withIdentifier: "CollectViewCell", for: indexPath)
            let creaturesCell = cell as! AllCreaturesTableViewCell
            creaturesCell.creaturesCollectionView.reloadData()
            
        }
        
        return cell
    }
 
    
    //MARK: - CollectionView
    
    
    
    //MARK: - Actions
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}