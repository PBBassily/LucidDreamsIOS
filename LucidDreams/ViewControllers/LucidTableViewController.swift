//
//  LucidTableViewController.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit



class LucidTableViewController: UITableViewController, SelectedCreaturePreviewDelegate{
   
    
    //MARK: -  Init
    var favCreature = LucidCreaturesFactory.getDefaultCreature()
    var dreams = LucidDreamsFactory.getDeafultDreamsBatch()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    // MARK: - TableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 : return "FAVORITE CREATURE"
        case 1 : return "DREAMS"
        default : return nil
        }
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
        let cell : UITableViewCell
        if indexPath.section == 0 {
            cell = prepareCellForMainCreature(indexPath) ?? UITableViewCell()
        }
        else {
            cell = prepareCellForDreams( indexPath) ?? UITableViewCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.lucidDreamCellHeight
    }
    
    // MARK: - TableView Cells preparation
    
    private func prepareCellForMainCreature( _ indexPath: IndexPath) -> UITableViewCell? {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath) as? LucidTableViewCell {
            
            cell.lucidLabel.text = favCreature.name
            
            let labelSize = cell.lucidImageView.frame.size
            cell.lucidImageView.image = ImageFactory.createImage(from: favCreature.imageIdentifier!, count:   1, of: labelSize)
            
            return cell
        }
        return nil
    }
    
    
    private func prepareCellForDreams(_ indexPath: IndexPath) -> UITableViewCell? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath) as? LucidTableViewCell {
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
            cell.accessoryType  = .disclosureIndicator
            return cell
        }
        return nil
    }
    
    
    // MARK: - TableView Actions & Editions
    
    
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
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    // MARK: - Duplication & Sharing Intersection
    
    
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
    
    @IBAction func leftButtonAction(_ sender: UIBarButtonItem) {
        
        
        // if sharing process, so left button action is to cancel sharing
        if isSharing {
            isSharing = false
            return
        }
        
        
        isDuplicating = !isDuplicating
        
        
        if isDuplicating{
            prepareCellsForDuplication()
        }
        else {
            doneEditingCellsAfterDuplication()
        }
        
    }
    
    @IBAction func rightButtonAction(_ sender: UIBarButtonItem) {
        
        if (!isSharing) {
            isSharing = true
            
            // go listen for multiple selection
            return
        }
        
        if let indepaths = tableView.indexPathsForSelectedRows , indepaths.count > 0   {
            shareImages(at : indepaths)
        }
        
        isSharing = false
    }

    
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
    private func prepareCellsForDuplication() {
        for i in 0 ..< dreams.count {
            tableView.cellForRow(at: IndexPath(row: i, section: 1))?.shouldIndentWhileEditing = true
            tableView.cellForRow(at: IndexPath(row: i, section: 1))?.setEditing(true, animated: true)
            
            
        }
    }
    private func doneEditingCellsAfterDuplication() {
        for i in 0 ..< dreams.count {
            tableView.cellForRow(at: IndexPath(row: i, section: 1))?.setEditing(false, animated: true)
        }
    }
    
    
    private func copySelected(_ indexPath: IndexPath, _ tableView: UITableView) {
        
        copyDreamAndAppend(at: indexPath)
        
        // update table after selection
        tableView.insertRows(at: [IndexPath(row: dreams.count-1, section: 1)], with: UITableViewRowAnimation.automatic )
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        doneEditingCellsAfterDuplication()
        
        // end duplication
        isDuplicating = false
    }
    
    private func copyDreamAndAppend(at indexPath: IndexPath) {
        
        let dreamCopy = dreams[indexPath.row].copy() as! Dream
        dreams.append(dreamCopy)
    }
    
   
    
    //MARK: - Sharing
    
    var isSharing = false {
        didSet {
            if isSharing {
                leftBarButton?.title = "Cancel"
                rightBarButton = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(rightButtonAction))
            } else {
                leftBarButton?.title = "Duplicate"
                rightBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightButtonAction))
            }
            
            tableView.allowsMultipleSelectionDuringEditing = true
            tableView.setEditing(isSharing, animated: true)
            
            
        }
    }
    
    
    
    
    
    
    private func shareImages(at indepaths: [IndexPath]) {
        // set up activity view controller
        let imagesToShare = indepaths.map {
            (tableView.cellForRow(at: $0) as! LucidTableViewCell).lucidImageView.image
        }
        
        //prepare activity controller
        let activityViewController = createShareActivityController(imagesToShare as! [UIImage])
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func createShareActivityController(_ imagesToShare: [UIImage]) -> UIActivityViewController {
        
    
        let activityViewController = UIActivityViewController(activityItems: imagesToShare  , applicationActivities: nil)
        activityViewController.modalPresentationStyle = .popover
        //activityViewController.popoverPresentationController?.barButtonItem = rightBarButton
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
        
        return activityViewController
    }
    
    //MARK: - CollectionView Delegation
    
    func creatureIsSelected(_ creature: Creature) {
        favCreature = creature
        tableView.reloadData()
    }
    
    
    
    // MARK: - Navigation
    
    
    func shouldNavigate() -> Bool {
        return !isDuplicating && !isSharing
    }
    
    
    private func navigateFromCell(at indexPath: IndexPath) {
        if indexPath.section == 0 {
            segueForFavouriteCreatureActivity()

            
        } else {
            segueForDreamComposingActivity(indexPath)
        }
    }
    
    private func segueForFavouriteCreatureActivity()  {
        if let navcon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavCreatureViewControllerNavigator") as? UINavigationController ,
            let targetViewController =  navcon.childViewControllers[0] as? FavCreatureTableViewController {
            
            targetViewController.delegate = self
            targetViewController.chosenCreature = favCreature
             self.present(navcon, animated: true, completion: nil)
        }
    }
    
    private func segueForDreamComposingActivity(_ indexPath: IndexPath) {
        if let rootNavcon = navigationController ,
            let targetViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DreamsViewConroller") as? DreamTableViewController {
            
            targetViewController.mainDream = dreams[indexPath.row]
            rootNavcon.pushViewController(targetViewController, animated: true)
            
        }
    }
    
}
