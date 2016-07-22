//
//  HomeViewController.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController
{
    // MARK: - all fields that relate public accessing
    
    // the String that holds which View controller called this controller
    var currentCaller = ""
    
    
    // MARK: - all fields that relate to the UI View
    
    // this represent the Navigation Bar Button Item that will open the side menu
    private var menuBarButtonItem: UIBarButtonItem!
    
    // this represent the Navigation Bar Button Item that show the logo
    private var logoBarButtonItem: UIBarButtonItem!
    
    // the Button that will display a blur View over the screen
    private var blurEffectButton: UIButton!
    
    // the Button that will display a blur View over the Navigation Bar
    private var blurEffectButton2: UIButton!
    
    // the Button that will allow user to view their email
    private var emailButton: UIButton!
    
    // the Button that will allow user to view their calendar
    private var calendarButton: UIButton!
    
    // the Button that will allow user to view their spot note
    private var spotNoteButton: UIButton!
    
    // the Button that will allow user to view anything locator
    private var anythingLocatorButton: UIButton!
    
    // the Button that will allow user to view their profile
    private var viewProfileButton: UIButton!
    
    // the CGFloat that will contain the total height of the navigation bar and status bar
    private var navigationAndStatusBarHeight: CGFloat = 64
    
    // the Search Bar that will allow users to search
    private let SMESearchBar: UISearchBar = UISearchBar()
    
    
    
    
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
        UniversalResources.TOP_VC = "HomeViewController"
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
    
    
    
    // MARK: - all functions that relate to the objects that calls these functions through an action
    
    /// <summary>
    /// Open the users email.
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func openEmail(sender: UIButton)
    {
        
    }
    
    /// <summary>
    /// Open the users calendar
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func openCalendar(sender: UIButton)
    {
        
    }
    
    /// <summary>
    /// Open Spot Note.
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func openSpotNote(sender: UIButton)
    {
        
    }
    
    /// <summary>
    /// Open Anything Locator.
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func openAnythingLocator(sender: UIButton)
    {
        
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
        
        // set up the blur effect Button and the attributes
        blurEffectButton = UIButton(type: UIButtonType.Custom)
        blurEffectButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + navigationAndStatusBarHeight)
        blurEffectButton.backgroundColor = UIColor.whiteColor()
        blurEffectButton.alpha = 0.75
        blurEffectButton.enabled = true
        
        // set up the blur effect Button and the attributes
        blurEffectButton2 = UIButton(type: UIButtonType.Custom)
        blurEffectButton2.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + navigationAndStatusBarHeight)
        blurEffectButton2.backgroundColor = UIColor.whiteColor()
        blurEffectButton2.alpha = 0.75
        blurEffectButton2.enabled = false
        blurEffectButton2.addTarget(self, action: #selector(HomeViewController.removeBlurEffect), forControlEvents: UIControlEvents.TouchUpInside)
        
        // set up the search bar
        setUpSMESearchBar()
        
        // set up the app buttons
        setUpAppButtons()
    }
    
    /// <summary>
    /// Adds the blur effect.
    /// </summary>
    func addBlurEffect()
    {
        // if the add blur effect is called from a different controller other than Side Menu View Controller, change the backdrop to black instead of whiteColor
        if currentCaller != "SideMenuViewController"
        {
            // set up the blur effect to become black and add to the View
            blurEffectButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + navigationAndStatusBarHeight)
            blurEffectButton.backgroundColor = UIColor.blackColor()
            
            // animate the alpha
            UIView.animateWithDuration(self.revealViewController().toggleAnimationDuration, animations: {
                self.blurEffectButton.alpha = 0.5
            })
            
            // set up the blur effect to become black and add to the View
            blurEffectButton2.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height:navigationAndStatusBarHeight)
            blurEffectButton2.backgroundColor = UIColor.blackColor()
            
            // animate the alpha
            UIView.animateWithDuration(self.revealViewController().toggleAnimationDuration, animations: {
                self.blurEffectButton2.alpha = 0.5
            })
            
            // add the Button to the Navigation Controller so it covers the entire View
            navigationController!.view.addSubview(blurEffectButton2)
            view.addSubview(blurEffectButton)
        }
        // called from Side Menu View Controller
        else
        {
            // set up the blur effect and add to the View
            blurEffectButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + navigationAndStatusBarHeight)
            blurEffectButton.backgroundColor = UIColor.whiteColor()
            
            // animate the alpha
            UIView.animateWithDuration(self.revealViewController().toggleAnimationDuration, animations: {
                self.blurEffectButton.alpha = 0.5
            })
            
            // set up the blur effect and add to the View
            blurEffectButton2.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height:navigationAndStatusBarHeight)
            blurEffectButton2.backgroundColor = UIColor.whiteColor()
            
            // animate the alpha
            UIView.animateWithDuration(self.revealViewController().toggleAnimationDuration, animations: {
                self.blurEffectButton2.alpha = 0.5
            })
            
            // add the Button to the Navigation Controller so it covers the entire View
            navigationController!.view.addSubview(blurEffectButton2)
            view.addSubview(blurEffectButton)
        }
    }
    
    /// <summary>
    /// Removes the blur effect.
    /// </summary>
    func removeBlurEffect()
    {
        // set the animation time
        let animationTime = self.revealViewController().toggleAnimationDuration
        
        // animate the alpha
        UIView.animateWithDuration(animationTime, animations: {
            self.blurEffectButton.alpha = 0.0
            self.blurEffectButton2.alpha = 0.0
        })
        
        // give a little animation by delaying the update
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(animationTime * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue())
        {
            self.blurEffectButton.removeFromSuperview()
            self.blurEffectButton2.removeFromSuperview()
        }
        
        // only toggle if the caller is from the SideMenuViewController
        if currentCaller == "SideMenuViewController"
        {
            // close the side menu
            self.revealViewController().rightRevealToggleAnimated(true)
        }
    }
    
    /// <summary>
    /// Removes the blur effect without animation.
    /// </summary>
    func removeBlurEffectNoAnimation()
    {
        // remove the Blur
        self.blurEffectButton.alpha = 0.0
        self.blurEffectButton.removeFromSuperview()
        self.blurEffectButton2.alpha = 0.0
        self.blurEffectButton2.removeFromSuperview()
        
        // close the side menu
        self.revealViewController().rightRevealToggleAnimated(true)
    }
    
    
    
    // MARK: - all functions that relate to the internal class
    
    /// <summary>
    /// Sets up the navigation items.
    /// </summary>
    private func setUpNavigationItems()
    {
        // set up the attributes of the navigation controller
        navigationController?.navigationBar.barTintColor = UniversalResources.UI_APP_COLOR_TINT
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        // set up the menu Bar Button Item
        menuBarButtonItem = UIBarButtonItem ()
        
        // set the left and right Bar Button Items
        navigationItem.setLeftBarButtonItem(menuBarButtonItem, animated: true)
        navigationItem.rightBarButtonItems?.removeAll()
        
        // if the Reveal View Controller is not null, set up the Reveal View Controller
        if self.revealViewController() != nil
        {
            // set up the Bar Button attributes
            menuBarButtonItem.target = self.revealViewController()
            menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
            menuBarButtonItem.image = UniversalResources.MENU_IMAGE
            menuBarButtonItem.style = UIBarButtonItemStyle.Plain
            
            // set up the Reveal View Controller Gesture
            self.revealViewController().panGestureRecognizer()
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // set up the Side Menu View Controller access to this View Controller
            (self.revealViewController().rearViewController as! SideMenuViewController).hvc = self
            (self.revealViewController().rearViewController as! SideMenuViewController).currentCaller = "HomeViewController"
        }
    }
    
    /// <summary>
    /// Sets up the SME search bar
    /// </summary>
    private func setUpSMESearchBar()
    {
        // set up the frame
        SMESearchBar.frame = CGRect(x: view.center.x, y: 20, width: 100, height: 30)
        SMESearchBar.text = "I need help with..."
        
        // add the Views
        view.addSubview(SMESearchBar)
    }
    
    /// <summary>
    /// Sets up the app Buttons
    /// </summary>
    private func setUpAppButtons()
    {
        // the Button width/height
        let buttonWidth: CGFloat = 30
        let buttonHeight: CGFloat = 30
        
        // set up the email Button
        var yPos = SMESearchBar.frame.origin.y + SMESearchBar.frame.height + 10
        var xPos = SMESearchBar.frame.origin.x
        emailButton = UIButton ()
        emailButton.setImage(UniversalResources.EMAIL_IMAGE, forState: UIControlState.Normal)
        emailButton.backgroundColor = UIColor.clearColor()
        emailButton.frame = CGRect(x: xPos, y: yPos, width: buttonWidth, height: buttonHeight)
        emailButton.addTarget(self, action: #selector(HomeViewController.openEmail(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        xPos = SMESearchBar.frame.origin.x + SMESearchBar.frame.width - buttonWidth
        calendarButton = UIButton ()
        calendarButton.setImage(UniversalResources.CALENDAR_IMAGE, forState: UIControlState.Normal)
        calendarButton.backgroundColor = UIColor.clearColor()
        calendarButton.frame = CGRect(x: xPos, y: yPos, width: buttonWidth, height: buttonHeight)
        calendarButton.addTarget(self, action: #selector(HomeViewController.openCalendar(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        xPos = SMESearchBar.frame.origin.x
        yPos = emailButton.frame.origin.y + emailButton.frame.height + 10
        spotNoteButton = UIButton ()
        spotNoteButton.setImage(UniversalResources.SPOT_NOTE_IMAGE, forState: UIControlState.Normal)
        spotNoteButton.backgroundColor = UIColor.clearColor()
        spotNoteButton.frame = CGRect(x: xPos, y: yPos, width: buttonWidth, height: buttonHeight)
        spotNoteButton.addTarget(self, action: #selector(HomeViewController.openSpotNote(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        xPos = calendarButton.frame.origin.x
        anythingLocatorButton = UIButton ()
        anythingLocatorButton.setImage(UniversalResources.ANYTHING_LOCATOR_IMAGE, forState: UIControlState.Normal)
        anythingLocatorButton.backgroundColor = UIColor.clearColor()
        anythingLocatorButton.frame = CGRect(x: xPos, y: yPos, width: buttonWidth, height: buttonHeight)
        anythingLocatorButton.addTarget(self, action: #selector(HomeViewController.openAnythingLocator(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // add the Views
        view.addSubview(emailButton)
        view.addSubview(calendarButton)
        view.addSubview(spotNoteButton)
        view.addSubview(anythingLocatorButton)
    }
}