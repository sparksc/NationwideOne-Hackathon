//
//  SideMenuViewController.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController
{
    // MARK: - all fields that relate public accessing
    
    // the instance of the HomeViewController
    var hvc: HomeViewController!
    
    // the String to hold which View Controller revealed this View Controller
    var currentCaller: String!
    
    
    
    // MARK: - all fields that relate to the UI View
    
    // the title bar Button
    private var nationwideOneTitleBarButton: UIButton!
    
    // the extra spacing Button
    private var extraSpacingButton: UIButton!
    
    // the CGFloat that will contain the total height of the navigation bar and status bar
    private var navigationAndStatusBarHeight: CGFloat = 0.0
    
    
    
    // MARK: - all fields that relate to the Table View
    
    // the side menu Table View for the different Side Menu options
    private var sideMenuTableView: UITableView!
    
    // the Table View Data Data Source for the different Side Menu options
    private var sideMenuTableViewDataSource = SideMenuTableViewDataSource()
    
    
    
    // MARK: - all functions that relate to the View Controller super class
    
    /// <summary>
    /// The function that gets called when the View loads.
    /// </summary>
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set the status bar style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        // update the status bar style
        self.setNeedsStatusBarAppearanceUpdate()
        
        // sets up the View to not extend under navigation bar top
        self.edgesForExtendedLayout = UIRectEdge.None
        
        // set up the total height needed to take account for when setting up the View
        navigationAndStatusBarHeight =  64
        
        // set up the menu layout
        setUpMenu ()
    }
    
    /// <summary>
    /// The function that gets called when the View will appear.
    /// </summary>
    /// <param name="animated">If set to <c>true</c> animated.</param>
    override func viewWillAppear (animated: Bool)
    {
        super.viewWillAppear (animated)
        
        // if this View Controller was revealed by the HomeViewController
        if currentCaller == "HomeViewController"
        {
            // set the current caller for the View Controller
            hvc.currentCaller = "SideMenuViewController"
            
            // add the blur effect to the HomeViewController
            hvc.addBlurEffect()
            
            // set the top View Controller
            UniversalResources.TOP_VC = "SideMenuViewController"
        }
    }
    
    /// <summary>
    /// The function that gets called when the View will disappear.
    /// </summary>
    /// <param name="animated">If set to <c>true</c> animated.</param>
    override func viewWillDisappear (animated: Bool)
    {
        super.viewWillDisappear (animated)
        
        // if this View Controller was revealed by the HomeViewController
        if currentCaller == "HomeViewController"
        {
            // remove the blur effect if the user has closed this View themself and not from selecting a menu option
            if hvc.currentCaller == "SideMenuViewController"
            {
                // remove the blur effect from the HomeViewController
                hvc.removeBlurEffect()
            }
        }
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
    
    
    
    
    // MARK: - all functions that relate to the internal class for public accessing
    
    /// <summary>
    /// Goes to the specified menu option.
    /// </summary>
    /// <param name="menuOption">Menu option.</param>
    func goToMenuOption(menuOption: String)
    {
        // check which selection was made from the menu options and take the user to that option
        if menuOption == MenuOption.MENU_OPTION_HOME
        {
            // if this View Controller was revealed by the HomeViewController
            if currentCaller == "HomeViewController"
            {
                // toggle the Side Menu
                // remove the blur effect from the HomeViewController
                hvc.removeBlurEffectNoAnimation()
            }
        }
        else if menuOption == MenuOption.MENU_OPTION_PROFILE
        {
            // for presenting instatiate the View Controller
            let profileViewController = UniversalResources.STORYBOARD.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
            
            // set up a Navigation Controller for the View being instantiated
            let navigationController = UINavigationController(rootViewController: profileViewController)
            navigationController.navigationBar.barTintColor = UniversalResources.UI_APP_COLOR_TINT
            navigationController.navigationBar.tintColor = UIColor.whiteColor()
            navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            navigationController.navigationBar.barStyle = UIBarStyle.Black
            
            // set the current profile
            profileViewController.currentProfile = UniversalResources.SIGNED_IN_PROFILE
                
            // set up the view
            profileViewController.setUpView()
            
            // present View Controller
            hvc.presentViewController (navigationController, animated: true, completion: nil)
        }
        else if menuOption == MenuOption.MENU_OPTION_E_BIZ
        {
            
        }
        else if menuOption == MenuOption.MENU_OPTION_RSS_FEED
        {
           
        }
        else if menuOption == MenuOption.MENU_OPTION_TODAYS_CAFE
        {
            
        }
        else if menuOption == MenuOption.MENU_OPTION_SETTINGS
        {
            
        }
        else if menuOption == MenuOption.MENU_OPTION_LEAVE_FEEDBACK
        {
            
        }
        else if menuOption == MenuOption.MENU_OPTION_CONTACT_US
        {
            
        }
        else if menuOption == MenuOption.MENU_OPTION_SIGN_OUT
        {
            // create the AlertController
            let alertController: UIAlertController = UIAlertController(title: "", message: "Are you sure you want to sign out?", preferredStyle: .Alert)
            
            // create and add the "Cancel" action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                // dismiss the action sheet
            }
            
            // create and add the "Yes" action
            let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Destructive) { action -> Void in
                
                // if this View Controller was revealed by the HomeViewController
                if self.currentCaller == "HomeViewController"
                {
                    // toggle the Side Menu
                    // remove the blur effect from the HomeViewController
                    self.hvc.removeBlurEffect()
                }
                
                // for presenting instatiate the View Controller
                let loadingAlertViewController = UniversalResources.STORYBOARD.instantiateViewControllerWithIdentifier("LoadingAlertViewController") as! LoadingAlertViewController
                loadingAlertViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                loadingAlertViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
                
                // present View controller
                self.presentViewController (loadingAlertViewController, animated: true, completion: nil)
                
                // set up the View
                loadingAlertViewController.setUpStyleOneView()
                
                // give a little animation by delaying the update
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(2 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue())
                {
                    // close the View
                    loadingAlertViewController.closeView()
                    
                    // go back to Sign In menu
                    self.hvc.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
            
            // add the actions
            alertController.addAction(cancelAction)
            alertController.addAction(yesAction)
            
            // present the AlertController
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - all functions that relate to the internal class
    
    /// <summary>
    /// Sets up the Menu View
    /// </summary>
    private func setUpMenu()
    {
        // if the Table View has already been set up yet, remove from View
        if sideMenuTableView != nil
        {
            // go through all the subviews and remove the Table View so it can be updated
            for subUIView in view.subviews
            {
                if subUIView == sideMenuTableView
                {
                    subUIView.removeFromSuperview ()
                }
            }
        }
        
        // set up the title View
        setUpTitleView()
        
        // set up the tableview
        setUpTableView()
    }
    
    /// <summary>
    /// Sets up the title View
    /// </summary>
    private func setUpTitleView()
    {
        // set up an Xperience title bar and the attributes
        var height = navigationAndStatusBarHeight
        nationwideOneTitleBarButton = UIButton(type: UIButtonType.Custom)
        nationwideOneTitleBarButton.titleLabel!.font = UIFont(name: UniversalResources.FONT_NAME_REGULAR, size:30)
        nationwideOneTitleBarButton.frame = CGRect(x: 0, y: 0, width: revealViewController().rearViewRevealWidth, height: height)
        nationwideOneTitleBarButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        nationwideOneTitleBarButton.backgroundColor = UniversalResources.UI_APP_COLOR_TINT
        nationwideOneTitleBarButton.setImage(UniversalResources.LOGO_WHITE_IMAGE, forState: UIControlState.Normal)
        nationwideOneTitleBarButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        nationwideOneTitleBarButton.enabled = false
        
        // set up a height for the extra spacing Button
        height = nationwideOneTitleBarButton.frame.height
        
        // set up the extra spacing to mask any white space if the user extends the Side Menu View
        extraSpacingButton = UIButton(type: UIButtonType.Custom)
        extraSpacingButton.enabled = false
        extraSpacingButton.backgroundColor = UniversalResources.UI_APP_COLOR_TINT
        extraSpacingButton.frame = CGRect(x: nationwideOneTitleBarButton.frame.width, y: 0, width: view.frame.width, height: height)
        
        // add the Views
        view.addSubview(nationwideOneTitleBarButton)
        view.addSubview(extraSpacingButton)
    }
    
    /// <summary>
    /// Sets up the Table View
    /// </summary>
    private func setUpTableView()
    {
        // prepare to set the height of the Table View
        var height: CGFloat = 0.00
        
        // prepare to set the y position of the Table View
        var yPos: CGFloat = 0.00
        
        // set the height based on the number of rows and the height of the rows
        height = 44.00 * CGFloat(UniversalResources.SIDE_MENU_ITEMS.count)
        
        // set the yPosition based on the user's email Button location
        yPos = nationwideOneTitleBarButton.frame.origin.y + nationwideOneTitleBarButton.frame.height
        
        // set up the Table View frame
        let frame = CGRect(x: 0, y: yPos, width: view.frame.width, height: height)
        
        // set up the Table View and its attributes
        sideMenuTableViewDataSource = SideMenuTableViewDataSource()
        sideMenuTableViewDataSource.menuTableItems = UniversalResources.SIDE_MENU_ITEMS
        sideMenuTableViewDataSource.menuDescriptionTableItems = UniversalResources.SIDE_MENU_DESCRIPTION_ITEMS
        sideMenuTableViewDataSource.smvc = self
        
        sideMenuTableView = UITableView(frame: frame, style: UITableViewStyle.Plain)
        sideMenuTableView.delegate = sideMenuTableViewDataSource
        sideMenuTableView.dataSource = sideMenuTableViewDataSource
        sideMenuTableView.separatorColor = UniversalResources.UI_APP_COLOR_TINT
        sideMenuTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        sideMenuTableView.backgroundColor = view.backgroundColor
        
        // make sure the custom class gets registered
        sideMenuTableView.registerClass(SideMenuTableViewCell.self, forCellReuseIdentifier: "SideMenuTableViewCell")
        
        // add the side menu Table View
        view.addSubview(sideMenuTableView)
    }
    
    /*
     /// <summary>
     /// Logs into the user's profile.
     /// </summary>
     private func logIn()
     {
     // if this View Controller was revealed by the MenuSelectionViewController
     if currentCaller == "MenuSelectionViewController"
     {
     // toggle the Side Menu
     // remove the blur effect from the MenuSelectionViewController
     msvc.removeBlurEffect()
     }
     // if this View Controller was revealed by the FoodMenuViewController
     else if currentCaller == "FoodMenuViewController"
     {
     // toggle the Side Menu
     // remove the blur effect from the FoodMenuViewController
     fmvc.removeBlurEffect()
     }
     // if this View Controller was revealed by the QuickSnackViewController
     else if currentCaller == "QuickSnackViewController"
     {
     // toggle the Side Menu
     // remove the blur effect from the QuickSnackViewController
     qsvc.removeBlurEffect()
     }
     
     // for presenting instatiate the View Controller
     let loadingAlertViewController = UniversalResources.STORYBOARD.instantiateViewControllerWithIdentifier("LoadingAlertViewController") as! LoadingAlertViewController
     loadingAlertViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
     loadingAlertViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
     
     // present View controller
     self.presentViewController (loadingAlertViewController, animated: true, completion: nil)
     
     // set up the View
     loadingAlertViewController.setUpStyleOneView()
     
     // give a little animation by delaying the update
     let time = DispatchTime(DispatchTime.now()) + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
     DispatchQueue.main.after(when: time)
     {
     // close the View
     loadingAlertViewController.closeView()
     
     // show the user is now logged in, and set up the menu
     self.loggedIn = true
     self.setUpMenu ()
     }
     }*/
}
