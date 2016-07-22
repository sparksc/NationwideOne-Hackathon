//
//  SMESearchListViewController.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/22/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class SMESearchListViewController: UIViewController, UISearchBarDelegate
{
    // MARK: - all fields that relate public accessing
    
    // the String that holds the current text
    var currentText = ""
    
    
    
    // MARK: - all fields that relate to the UI View
    
    // this represent the Navigation Bar Button Item that will take user back to homepage
    private var backBarButtonItem: UIBarButtonItem!
    
    // the Tap Gesture Recognizer to tell if the user tapped on any of the Views
    private var tappedOffKeyboardGesture: UITapGestureRecognizer!
    
    // the Image View that will be laid over the View to protect the information if the user minimizes the application
    private var nationwideOneCoverImageView: UIImageView!
    
    // the Image that for the cover image to protect the information
    private let nationwideOneCoverImage: UIImage = UniversalResources.NATIONWIDE_ONE_RETINA_IMAGE
    
    // the CGFloat that will contain the total height of the navigation bar and status bar
    private var navigationAndStatusBarHeight: CGFloat = 64
    
    // the Search Controller that will allow users to search
    private let searchController = UISearchController(searchResultsController: nil)

    // the Boolean that determines whether the keyboard was show when leaving the View Controller
    private var keyboardWasShown: Bool = false
    
    // the Array of UserProfile from the searc
    private var filteredUserProfile = [UserProfile]()
    
    
    
    
    
    // MARK: - all fields that relate to the Table View
    
    // the Table View of the search list items
    private var smeSearchListTableView: UITableView!
    
    // the Table View Data Source
    private var smeSearchListTableViewDataSource: SMESearchTableViewDataSource!
    
    
    
    
    
    // MARK: - all functions that relate to the View Controller super class
    
    /// <summary>
    /// The function that gets called when the View loads.
    /// </summary>
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set up a notification for when the keyboard is shown
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SMESearchListViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        // refresh the View when the notification (Moving To Inactive) happens
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SMESearchListViewController.movingToInactive(_:)), name: "Moving To Inactive", object: nil)
        
        // refresh the View when the notification (Did Become Active) happens
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SMESearchListViewController.didBecomeActive(_:)), name: "Did Become Active", object: nil)
        
        // set the status bar style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        // update the status bar style
        self.setNeedsStatusBarAppearanceUpdate()
        
        // sets up the View to not extend under navigation bar top
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    /// <summary>
    /// The function that gets called when the View will appear.
    /// </summary>
    /// <param name="animated">If set to <c>true</c> animated.</param>
    override func viewWillAppear (animated: Bool)
    {
        super.viewWillAppear (animated)
        
        // set the top View Controller
        UniversalResources.TOP_VC = "SMESearchListViewController"
    }
    
    /// <summary>
    /// The function that gets called when the View will disappear.
    /// </summary>
    /// <param name="animated">If set to <c>true</c> animated.</param>
    override func viewWillDisappear (animated: Bool)
    {
        super.viewWillDisappear (animated)
    }
    
    /// <summary>
    /// The function that gets called when receiving a memory warning
    /// </summary>
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// <summary>
    /// The function that gets called when the View controller checks if the status bar should be hidden
    /// </summary>
    override func prefersStatusBarHidden() -> Bool
    {
        // return false so the status bar is not hidden
        return false
    }
    
    /// <summary>
    /// The function that gets called when the View controller checks if the status bar preferred style
    /// </summary>
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        // return the style
        return UIStatusBarStyle.LightContent
    }

    
    
    
    // MARK: - all functions that relate to the internal class for the Text View Delegate
    
    func filterContentForSearchText(searchText: String, scope: String = "All")
    {
        if searchText != "I need help with..."
        {
            filteredUserProfile = UniversalResources.PROFILES.filter
            {
                profile in
                return profile.specialties.lowercaseString.containsString(searchText.lowercaseString) || profile.hobbies.lowercaseString.containsString(searchText.lowercaseString)
                    || profile.aboutMe.lowercaseString.containsString(searchText.lowercaseString)
                    || profile.title.lowercaseString.containsString(searchText.lowercaseString)
                    || profile.department.lowercaseString.containsString(searchText.lowercaseString)
            }
            
            // set up the frame
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: CGFloat((filteredUserProfile.count + 1) * 44))
            smeSearchListTableView.frame = frame
            smeSearchListTableViewDataSource.tableKeys = filteredUserProfile
            smeSearchListTableView.reloadData()
        }
    }
    
    
    // MARK: - all functions that relate to the search bar delegate
    
    /// <summary>
    /// Determines if the search bar should begin editing
    /// </summary>
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        // if this is the start of a search
        if searchBar.text == "I need help with..."
        {
            // clear the text
            searchBar.text = ""
        }
        
        return true
    }
    
    /// <summary>
    /// Determines if the search bar should end editing
    /// </summary>
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        // if the user didn't enter text
        if searchBar.text == ""
        {
            // set the text
            searchBar.text = "I need help with..."
        }
        
        return true
    }
    
    /// <summary>
    /// When the search Button is clicked.
    /// </summary>
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        currentText = searchBar.text!
    }

    /// <summary>
    /// When the cancel Button is clicked.
    /// </summary>
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = currentText
        filteredUserProfile = []
        
        // set up the frame
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: CGFloat(44))
        smeSearchListTableView.frame = frame
        smeSearchListTableViewDataSource.tableKeys = filteredUserProfile
        smeSearchListTableView.reloadData()
    }
    
    
    
    // MARK: - all functions that relate to the objects that calls these functions through an action
    
    /// <summary>
    /// Called when the keyboard is about to show
    /// </summary>
    /// <param name="notification"> The object that called this funcion.</param>
    func keyboardWillShow(notification: NSNotification)
    {
        // set up the user info from the notification
        let userInfo: NSDictionary = notification.userInfo!
        let keyboardFrame: NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        
        // if the height does match, update the height
        if keyboardRectangle.height != UniversalResources.SCROLL_AMOUNT
        {
            // if the caller is this View Controller
            if UniversalResources.KEYBOARD_VIEW_CONTROLLER_LOCATION == "SignInViewController"
            {
                // update the height
                UniversalResources.SCROLL_AMOUNT = keyboardRectangle.height
            }
        }
        
        // if the caller is this View Controller
        if UniversalResources.KEYBOARD_VIEW_CONTROLLER_LOCATION == "SignInViewController"
        {
            // show the keyboard is visible
            keyboardWasShown = true
        }
    }
    
    /// <summary>
    /// Called when the application is active
    /// </summary>
    /// <param name="notification"> The object that called this funcion.</param>
    func didBecomeActive(notification: NSNotification)
    {
        // if this View Controller is the top View Controller of the application
        if UniversalResources.TOP_VC == "SignInViewController"
        {
            // if the Image View was set up
            if nationwideOneCoverImageView != nil
            {
                // remove the View
                nationwideOneCoverImageView.removeFromSuperview()
            }
            
            // if the keyboard was shown when they View left
            if keyboardWasShown
            {
                // make the Text View the current responder
                searchController.searchBar.becomeFirstResponder()
            }
        }
    }
    
    /// <summary>
    /// Called when the application is moving to become inactive
    /// </summary>
    /// <param name="notification"> The object that called this funcion.</param>
    func movingToInactive(notification: NSNotification)
    {
        // if this View Controller is the top View Controller of the application
        if UniversalResources.TOP_VC == "SignInViewController"
        {
            // if the Image View was set up
            if nationwideOneCoverImageView != nil
            {
                // protect the information by adding the cover View
                navigationController?.view.addSubview(nationwideOneCoverImageView)
            }
            
            // to hold the value before closing the keyboard
            let keyboardWasUp = keyboardWasShown
            
            // release the responder
            searchController.searchBar.resignFirstResponder()
            
            // set the state before force closing
            keyboardWasShown = keyboardWasUp
        }
    }
    
    /// <summary>
    /// Closes keyboard View.
    /// </summary>
    /// <param name="sender">Sender button.</param>
    func closeKeyboardView(sender: UIButton)
    {
        // show the keyboard is no longer visible
        keyboardWasShown = false
    }
    
    /// <summary>
    /// When the view is tapped.
    /// </summary>
    /// <param name="tapGestureRecognizer"> UITapGestureRecognizer that called this funcion.</param>
    func tappedOffKeyboard(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // check if the keyboard is up, and close if it is
        closeKeyboardIfNecessary()
    }

    /// <summary>
    /// Returns the user back to the Food Menu
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func closeView(sender: UIBarButtonItem)
    {
        // go back to previous View Controller
        navigationController?.popViewControllerAnimated(true)
    }
    
    /// <summary>
    /// Called when a cell for the Food Menu Item is long pressed.
    /// </summary>
    /// <param name="longPressGestureRecognizer">UILongPressGestureRecognizer that called this function.</param>
    func cellPress(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // get the current state, if it began
        if tapGestureRecognizer.state == UIGestureRecognizerState.Began
        {
            
        }
        // get the current state, if it has ended
        else if tapGestureRecognizer.state == UIGestureRecognizerState.Ended
        {
            // get the touch point in the Table View
            let touchPoint = tapGestureRecognizer.locationInView(smeSearchListTableView)
            
            // get the index path of that cell
            let indexPath = smeSearchListTableView.indexPathForRowAtPoint(touchPoint)
            
            // if an index path exists
            if indexPath != nil
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
                profileViewController.currentProfile = filteredUserProfile[indexPath!.row]
                
                // set up the view
                profileViewController.setUpView()
                
                // present View Controller
                presentViewController (navigationController, animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - all functions that relate to the internal class for public accessing
    
    /// <summary>
    /// Sets up the navigation items.
    /// </summary>
    func setUpView()
    {
        // set up the navigation items
        setUpNavigationItems()
        
        // set up the total height needed to take account for when setting up the View
        navigationAndStatusBarHeight =  navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height
        
        // set up the tap gesture to be able to dismiss keyboard when user taps away
        tappedOffKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.tappedOffKeyboard(_:)))
        
        
        // add the gesture recognizer
        self.view.addGestureRecognizer(tappedOffKeyboardGesture)
        
        // set up the Image View for the View protecting image
        nationwideOneCoverImageView = UIImageView ()
        nationwideOneCoverImageView.backgroundColor = UIColor.clearColor()
        nationwideOneCoverImageView.image = nationwideOneCoverImage
        nationwideOneCoverImageView.frame = CGRect(x: 0, y: 0.0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        // set up the search bar
        setUpSMESearchBar()
        
        // set up the Table View
        setUpTableView()
    }

    // MARK: - all functions that relate to the internal class
    
    /// <summary>
    /// Sets up the navigation items.
    /// </summary>
    private func setUpNavigationItems()
    {
        // set up a tmp view
        let tmpImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        tmpImageView.image = UniversalResources.LOGO_WHITE_IMAGE
        
        // set up the attributes of the navigation controller
        navigationController?.navigationBar.barTintColor = UniversalResources.UI_APP_COLOR_TINT
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBarHidden = false
        navigationItem.titleView = tmpImageView
        
        // set up the back Bar Button Item
        backBarButtonItem = UIBarButtonItem (title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SMESearchListViewController.closeView(_:)))
        
        // set the left and right Bar Button Items
        navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        navigationItem.rightBarButtonItems?.removeAll()
    }
    
    /// <summary>
    /// Sets up the SME search bar
    /// </summary>
    private func setUpSMESearchBar()
    {
        // set up the search controller
        searchController.searchBar.delegate = self
        searchController.searchBar.text = currentText
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    /// <summary>
    /// Sets up the Table View
    /// </summary>
    private func setUpTableView()
    {
        filteredUserProfile = UniversalResources.PROFILES.filter
        {
            profile in
            return profile.specialties.lowercaseString.containsString(currentText.lowercaseString) || profile.hobbies.lowercaseString.containsString(currentText.lowercaseString)
                || profile.aboutMe.lowercaseString.containsString(currentText.lowercaseString)
                || profile.title.lowercaseString.containsString(currentText.lowercaseString)
                || profile.department.lowercaseString.containsString(currentText.lowercaseString)
        }

        // set up the frame
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: CGFloat((filteredUserProfile.count + 1) * 44))
        
        // set up the Table View
        smeSearchListTableView = UITableView (frame: frame, style: UITableViewStyle.Plain)
        smeSearchListTableViewDataSource = SMESearchTableViewDataSource()
        smeSearchListTableViewDataSource.tableKeys = filteredUserProfile
        smeSearchListTableViewDataSource.sslvc = self
        smeSearchListTableViewDataSource.searchController = searchController
        smeSearchListTableView.separatorColor = UniversalResources.UI_APP_COLOR_TINT
        smeSearchListTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        smeSearchListTableView.backgroundColor = view.backgroundColor
        smeSearchListTableView.delegate = smeSearchListTableViewDataSource
        smeSearchListTableView.dataSource = smeSearchListTableViewDataSource
        smeSearchListTableView.registerClass(SMESearchTableViewCell.self, forCellReuseIdentifier: "SMESearchListTableViewCell")
        
        
        // set up the Long Press Gesture Recognizer for the Table View
        let tap = UITapGestureRecognizer(target: self, action: #selector(SMESearchListViewController.cellPress(_:)))
        smeSearchListTableView.addGestureRecognizer(tap)
        
        
        // add the subViews
        view.addSubview(smeSearchListTableView)
        
        smeSearchListTableView.tableHeaderView = searchController.searchBar
    }
    
    /// <summary>
    /// Scrolls the View.
    /// </summary>
    private func closeKeyboardIfNecessary()
    {
        // if the keyboard is currently up
        if keyboardWasShown
        {
            // release the focus
            searchController.searchBar.resignFirstResponder()
        }
    }
}

extension SMESearchListViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}