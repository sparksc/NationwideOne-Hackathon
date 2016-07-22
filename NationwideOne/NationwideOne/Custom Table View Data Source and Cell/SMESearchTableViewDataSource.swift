//
//  SMESearchTableViewDataSource.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/22/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class SMESearchTableViewDataSource: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // MARK: - all fields that relate to the Table View
    
    @IBOutlet var tableView: UITableView!
    
    // the Array of strings that holds the key values for the array
    var tableKeys: [UserProfile] = []
    
    
    
    // MARK: - all fields that relate to the SMESearchListViewController
    
    // the instance of the SMESearchListViewController
    var sslvc: SMESearchListViewController!
    
    // the search controller
    var searchController: UISearchController!
    
    
    // MARK: - all fields that relate to the internal class
    
    // the constant that represent the cell identifier
    private let cellIdentifier = "SMESearchListTableViewCell"
    
    
    
    
    
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
        return tableKeys.count
    }
    
    /// <summary>
    /// Called by the TableView to get the actual UITableViewCell to render for the particular row
    /// </summary>
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SMESearchTableViewCell
        
        // remove the margins from the cell
        removeMarginsFromCell (cell)
        
        // update the cell
        cell.updateCell (tableKeys[indexPath.row].name, menuDescription: tableKeys[indexPath.row].specialties, menuImage: UniversalResources.PROFILE_IMAGE)
        
        // return the updated cell
        return cell
    }
    
    /// <summary>
    /// Called by the TableView when a row is selected
    /// </summary>
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        // for presenting instatiate the View Controller
        let profileViewController = UniversalResources.STORYBOARD.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        
        // set up a Navigation Controller for the View being instantiated
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.navigationBar.barTintColor = UniversalResources.UI_APP_COLOR_TINT
        navigationController.navigationBar.tintColor = UIColor.whiteColor()
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController.navigationBar.barStyle = UIBarStyle.Black
        
        // set the item was selected
        profileViewController.currentProfile = tableKeys[indexPath.row]
        
        // set up the view
        profileViewController.setUpView()
        
        // present View Controller
        sslvc.presentViewController (navigationController, animated: true, completion: nil)
        
        // deselect the row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*
    /// <summary>
    /// Called by the TableView when a getting the height for section
    /// </summary>
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }*/
    
    
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
}