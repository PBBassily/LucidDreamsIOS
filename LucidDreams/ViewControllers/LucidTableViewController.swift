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
    var leftBarButton : UIBarButtonItem? {
        get {
            return navigationItem.leftBarButtonItem
        }
        set {
            navigationItem.leftBarButtonItem = newValue
        }
    }
    var rightBarButton : UIBarButtonItem? {
        get {
            return navigationItem.rightBarButtonItem
        }
        set {
            navigationItem.rightBarButtonItem = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelectionDuringEditing = true
        
        
        //leftBarButton = navigationItem.leftBarButtonItem
        //rightBarButton = navigationItem.rightBarButtonItem
        
        //   tableView.allowsMultipleSelectionDuringEditing = false
        
        
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
            
            cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath) as! LucidTableViewCell
            cell.lucidLabel.text = favCreature.name
            cell.lucidImageView.contentMode = .scaleAspectFit
            cell.lucidImageView.image = UIImage(named: favCreature.imageIdentifier!)
            
            
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath) as! LucidTableViewCell
            let dream = dreams[indexPath.row]
            dream.title = dream.title.trimmingCharacters(in: .whitespacesAndNewlines)
            if  dream.title == "" {
                dream.title = "Untitled"
            }
            cell.lucidLabel.text = dream.title
            
            if dream.number ==  0 {
                dream.number = 1
            }
            
            let labelSize = cell.lucidImageView.frame.size
            cell.lucidImageView.image = ImageFactory.createImage(from: dream.creature.imageIdentifier!, count: dream.number, of: labelSize)
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
    
    // MARK: - Duplication
    
    var isDuplicating = false {
        didSet {
            if self.isDuplicating {
                leftBarButton?.title = "Cancel"
            } else {
                leftBarButton?.title = "Duplicate"
            }
            
            
        }
    }
    
    
    
    fileprivate func accessoryTypeDislocureForAllCells() {
        for i in 0 ..< dreams.count {
            tableView.cellForRow(at: IndexPath(row: i, section: 1))?.setEditing(false, animated: true)
        }
    }
    
    fileprivate func accessoryTypeNoneForAllCells() {
        for i in 0 ..< dreams.count {
            tableView.cellForRow(at: IndexPath(row: i, section: 1))?.shouldIndentWhileEditing = true
            tableView.cellForRow(at: IndexPath(row: i, section: 1))?.setEditing(true, animated: true)
            
            
        }
    }
    
    @IBAction func duplicationAction(_ sender: UIBarButtonItem) {
        
        if isSharing {
            isSharing = false
            return
        }
        
        isDuplicating = !isDuplicating
        
        
        if isDuplicating{
            accessoryTypeNoneForAllCells()
        }
        else {
            accessoryTypeDislocureForAllCells()
        }
        
    }
    
    private func copyDreamAndAppend(at indexPath: IndexPath) {
        
        let dreamCopy = dreams[indexPath.row].copy() as! Dream
        dreams.append(dreamCopy)
    }
    
    private func copySelected(_ indexPath: IndexPath, _ tableView: UITableView) {
        
        copyDreamAndAppend(at: indexPath)
        
        // update table after selection
        tableView.insertRows(at: [IndexPath(row: dreams.count-1, section: 1)], with: UITableViewRowAnimation.automatic )
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        accessoryTypeDislocureForAllCells()
        
        isDuplicating = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let isSelectedForNavigation = shouldNavigate()
        
        if isSelectedForNavigation {
            navigateFromCell(at: indexPath)
        } else if isDuplicating {
            copySelected(indexPath, tableView)
        }
        // else is sharing
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    //MARK: - Sharing
    
    var isSharing = false {
        didSet {
            if isSharing {
                leftBarButton?.title = "Cancel"
                rightBarButton = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(imageShareAction))
            } else {
                leftBarButton?.title = "Duplicate"
                rightBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(imageShareAction))
            }
            
            tableView.allowsMultipleSelectionDuringEditing = true
            tableView.setEditing(isSharing, animated: true)
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func imageShareAction(_ sender: UIBarButtonItem) {
        
        if (!isSharing) {
            isSharing = true
            return
        }
        
        
        if let indepaths = tableView.indexPathsForSelectedRows , indepaths.count > 0   {
            
            //let image = UIImage(named: dreams[0].creature.imageIdentifier!)
            
            // set up activity view controller
            let imagesToShare = indepaths.map {
                (tableView.cellForRow(at: $0) as! LucidTableViewCell).lucidImageView.image
            }
            let activityViewController = UIActivityViewController(activityItems: imagesToShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
            
        }
        
        isSharing = false
    }
    
    //MARK: - Delegation
    
    func updateCreature(_ creature: Creature)  {
        favCreature = creature
        tableView.reloadData()
    }
    
    
    
    // MARK: - Navigation
    
    
    
    func navigateFromCell(at indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let navcon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavCreatureViewControllerNavigator") as? UINavigationController ,
                let viewController =  navcon.childViewControllers[0] as? FavCreatureTableViewController {
                viewController.delegate = self
                viewController.chosenCreature = favCreature
                self.present(navcon, animated: true, completion: nil)
                
            }
            
        } else {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DreamsViewConroller") as? DreamTableViewController {
                if let navigator = navigationController {
                    viewController.mainDream = dreams[indexPath.row]
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
    func shouldNavigate() -> Bool {
        return !isDuplicating && !isSharing
    }
}
