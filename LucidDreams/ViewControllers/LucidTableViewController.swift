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
    private var favCreature = LucidCreaturesFactory.getDefaultCreature()
    private var dreams = LucidDreamsFactory.getDeafultDreamsBatch()
    private static let lucidDreamCellHeight =  CGFloat(90.0 * Constants.resizeFactor)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        let cell: UITableViewCell
        if indexPath.section == 0 {
            cell = prepareCellForMainCreature(indexPath) ?? UITableViewCell()
        } else {
            cell = prepareCellForDreams( indexPath) ?? UITableViewCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LucidTableViewController.lucidDreamCellHeight
    }
    
    // MARK: - TableView Cells preparation
    
    private func prepareCellForMainCreature( _ indexPath: IndexPath) -> UITableViewCell? {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath) as? LucidTableViewCell,
            let imageId = favCreature.imageIdentifier , let name = favCreature.name {
            
            let labelSize = cell.getImageViewSize()
            let creatureImage = ImageFactory.createImage(from: imageId, count:   1, of: labelSize)
            
            cell.configure(title: name, image: creatureImage)
            
            return cell
        }
        return nil
    }
    
    
    private func prepareCellForDreams(_ indexPath: IndexPath) -> UITableViewCell? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LucidDreamCell", for: indexPath) as? LucidTableViewCell {
            
            let dream = dreams[indexPath.row]
            let title = dream.title.trimmingCharacters(in: .whitespacesAndNewlines)
            dream.title = title == "" ? "Untitled" : title
            dream.number = dream.number < 1 ? 1 : dream.number
            let labelSize = cell.getImageViewSize()
            let image = ImageFactory.createImage(from: dream.creature?.imageIdentifier, count: dream.number, of: labelSize)
            cell.configure(title: dream.title, image: image)
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
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    // MARK: - Duplication & Sharing Intersection
    
    
    private var leftBarButton : UIBarButtonItem? {
        get {
            return navigationItem.leftBarButtonItem
        }
        set {
            navigationItem.leftBarButtonItem = newValue
        }
    }
    
    private var rightBarButton : UIBarButtonItem? {
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
    
    private var isDuplicating = false {
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
        
        updateTableViewAfterCopyDone(tableView, indexPath)
        
        doneCopying()
    }
    
    private func updateTableViewAfterCopyDone(_ tableView: UITableView, _ indexPath: IndexPath) {
        // update table after selection
        tableView.insertRows(at: [IndexPath(row: dreams.count-1, section: 1)], with: UITableViewRowAnimation.automatic )
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        doneEditingCellsAfterDuplication()
    }
    
    private func doneCopying() {
        isDuplicating = false
    }
    
    private func copyDreamAndAppend(at indexPath: IndexPath) {
        
        if let dreamCopy = dreams[indexPath.row].copy() as? Dream {
            dreams.append(dreamCopy)
        }
    }
    
    //MARK: - Sharing
    
    private var isSharing = false {
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
    
    private func getImagesSelected(at indepaths: [IndexPath]) -> [UIImage] {
        
        var images = [UIImage]()
        for indexPath in indepaths {
            let cell = tableView.cellForRow(at: indexPath)
            if let lucidCell = cell as? LucidTableViewCell ,let image = lucidCell.getImage() {
                images.append(image)
            }
        }
        return images
    }
    
    private func shareImages(at indexpaths: [IndexPath]) {
        
        let imagesToShare =  getImagesSelected(at: indexpaths)
        
        let activityViewController = createShareActivityController(imagesToShare)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func createShareActivityController(_ imagesToShare: [UIImage]) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: imagesToShare  , applicationActivities: nil)
        activityViewController.modalPresentationStyle = .popover
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
    
    
    private func shouldNavigate() -> Bool {
        return !isDuplicating && !isSharing
    }
    
    
    private func navigateFromCell(at indexPath: IndexPath) {
        if indexPath.section == 0 {
            goForFavouriteCreatureActivity()
            
            
        } else {
            goForDreamComposingActivity(indexPath)
        }
    }
    
    private func goForFavouriteCreatureActivity()  {
        if let navcon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavCreatureViewControllerNavigator") as? UINavigationController ,
            let targetViewController =  navcon.childViewControllers[0] as? FavCreatureTableViewController {
            
            targetViewController.configure(delegate: self, chosenCreature: favCreature)
            self.present(navcon, animated: true, completion: nil)
        }
    }
    
    private func goForDreamComposingActivity(_ indexPath: IndexPath) {
        if let rootNavcon = navigationController ,
            let targetViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DreamsViewConroller") as? DreamTableViewController {
            
            targetViewController.config(mainDream: dreams[indexPath.row])
            rootNavcon.pushViewController(targetViewController, animated: true)
            
        }
    }
    
}
