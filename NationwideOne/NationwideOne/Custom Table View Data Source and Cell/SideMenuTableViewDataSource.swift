//
//  SideMenuTableViewDataSource.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class SideMenuTableViewDataSource: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // MARK: - all fields that relate to the Table View
    
    @IBOutlet var tableView: UITableView!
    
    // the Array of Strings that holds the key values for the Array
    var menuTableItems: [String] = []
    
    // the Dictionary containing the Food item and the description
    var menuDescriptionTableItems = Dictionary<String, String>()
    
    
    
    // MARK: - all fields that relate to the SideMenuViewController
    
    // the instance of the SideMenuViewController
    var smvc: SideMenuViewController!
    
    
    
    // MARK: - all functions that relate to the internal class
    // the constant that represent the cell identifier
    let cellIdentifier = "SideMenuTableViewCell"
    
    
    
    // MARK: - all overrided functions that relate to the Table View Data Source super class
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - all functions that relate to the Table View Data Source
    
    /// <summary>
    /// Gets the number of sections in the Table View
    /// </summary>
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // return the number of sections
        return 1
    }
    
    
    /// <summary>
    /// Gets the number of rows in the section of the Table View
    /// </summary>
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // return the number of rows in the section
        return menuTableItems.count
    }
    
    /// <summary>
    /// Called by the TableView to get the actual UITableViewCell to render for the particular row
    /// </summary>
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SideMenuTableViewCell
        
        // remove the margins from the cell
        removeMarginsFromCell (cell)
        
        // the key of the section
        let name = menuTableItems[indexPath.row]
        
        // get the description of the item
        var desc = menuDescriptionTableItems[name]
        
        
        // if the food item does not have a description
        if desc == "None"
        {
            desc = ""
        }
        
        // get the image
        let image = getImageForName(name)
        
        // update the cell
        cell.updateCell(name, menuDescription: desc!, menuImage: image)
        
        // return the updated cell
        return cell
    }
    
    /// <summary>
    /// Called by the TableView when a row is selected
    /// </summary>
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        // get the cell that was selected
        let cell = tableView.cellForRowAtIndexPath (indexPath) as! SideMenuTableViewCell
        
        // go to the menu option
        smvc.goToMenuOption (cell.menuTitleLabel.text!)
        
        // deselect the row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    // MARK: - all functions that relate to the internal class
    
    /// <summary>
    /// Removes the margins from cell.
    /// </summary>
    /// <param name="cell">Cell.</param>
    private func removeMarginsFromCell(cell: UITableViewCell)
    {
        if cell.respondsToSelector (Selector ("setLayoutMargins:"))
        {
            cell.separatorInset = UIKit.UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        if cell.respondsToSelector(Selector ("setPreservesSuperviewLayoutMargins:"))
        {
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.respondsToSelector(Selector ("setLayoutMargins:"))
        {
            cell.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    
    /// <summary>
    /// Gets the image based on the name.
    /// </summary>
    /// <param name="name">The name.</param>
    private func getImageForName(name: String) -> UIImage
    {
        // if this is the "Home" cell
        if name.lowercaseString.containsString("home")
        {
            return UniversalResources.HOME_BLACK_IMAGE
        }
        // if this is the "Settings" cell
        else if name.lowercaseString.containsString("settings")
        {
            return UniversalResources.SETTINGS_IMAGE
        }
        // if this is the "Feedback" cell
        else if name.lowercaseString.containsString("feedback")
        {
            return UniversalResources.SUGGESTION_IMAGE
        }
        // if this is the "Contact Us" cell
        else if name.lowercaseString.containsString("contact")
        {
            return UniversalResources.PHONE_OUTLINE_BLACK_IMAGE
        }
        // if this is the "Sign In" cell
        else if name.lowercaseString.containsString("sign in")
        {
            return UniversalResources.SIGNIN_IMAGE
        }
        
        // return an empty image
        return UIImage()
    }
}