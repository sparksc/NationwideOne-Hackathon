//
//  AnythingLocatorViewController.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/22/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class AnythingLocatorViewController: UIViewController, UITextViewDelegate
{
    // MARK: - all fields that relate to the UI View
    
    // this represent the Navigation Bar Button Item that will take user back to homepage
    private var backBarButtonItem: UIBarButtonItem!
    
    // the Tap Gesture Recognizer to tell if the user tapped on any of the Views
    private var tappedOffKeyboardGesture: UITapGestureRecognizer!
    
    // the Image View that will be laid over the View to protect the information if the user minimizes the application
    private var nationwideOneCoverImageView: UIImageView!
    
    // the Image that for the cover image to protect the information
    private let nationwideOneCoverImage: UIImage = UniversalResources.NATIONWIDE_ONE_RETINA_IMAGE
    
    // the Boolean that determines whether the keyboard was show when leaving the View Controller
    private var keyboardWasShown = false
    
    // the Text View representing the building
    private var buildingTextView: UITextView!
    
    // the Text View representing the floor
    private var floorTextView: UITextView!

    // the String that holds the Picker View that the user has selected
    private var pickerViewCaller = ""
    
    // the Float that holds the Scroll View position when a Text View is selected
    private var scrollViewOffsetPosition = CGPointZero
    
    // the String that hold the text for the Credit Card number Text View caller
    private let buildingCaller = "building"
    
    // the String that hold the text for the building Text View caller
    private let floorCaller = "floor"
    
    // the String that holds the past building value
    private var building = "Select Building"
    
    // the String that holds the past floor value
    private var floor = "Select Floor"
    
    // the CGFloat that will contain the total height of the navigation bar and status bar
    private var navigationAndStatusBarHeight: CGFloat = 0.0
    
    
    
    // MARK: - all fields that relate to the Picker View
    
    // the Picker View representing the building
    private var buildingPickerView: UIPickerView!
    
    // the Picker View representing the floor
    private var floorPickerView: UIPickerView!
    
    // the Picker View Data Source for the building
    private var buildingPickerViewDataSource: PickerViewDataSource!
    
    // the Picker View Data Source for the floor
    private var floorPickerViewDataSource: PickerViewDataSource!
    
    // the Array of String that hold the building Picker View data
    private var buildingPickerViewData = ["Select Building"]
    
    // the Array of String that hold the floor Picker View data
    private var floorPickerViewData = ["Select Floor"]
    
    
    // MARK: - all functions that relate to the View Controller super class
    
    /// <summary>
    /// The function that gets called when the view loads.
    /// </summary>
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set the status bar style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        // sets up the view to not extend under navigation bar top
        self.edgesForExtendedLayout = UIRectEdge.None
        
        // set up a notification for when the keyboard is shown
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AnythingLocatorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        // refresh the View when the notification (Moving To Inactive) happens
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AnythingLocatorViewController.movingToInactive(_:)), name: "Moving To Inactive", object: nil)
        
        // refresh the View when the notification (Did Become Active) happens
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AnythingLocatorViewController.didBecomeActive(_:)), name: "Did Become Active", object: nil)
    }
    
    /// <summary>
    /// The function that gets called when the view will appear.
    /// </summary>
    /// <param name="animated">If set to <c>true</c> animated.</param>
    override func viewWillAppear (animated: Bool)
    {
        super.viewWillAppear (animated)
        
        // set the top View Controller
        UniversalResources.TOP_VC = "NewCreditCardViewController"
        
        // set the current keyboard location
        UniversalResources.KEYBOARD_VIEW_CONTROLLER_LOCATION = "NewCreditCardViewController"
    }
    
    /// <summary>
    /// The function that gets called when the view will disappear.
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
    /// Called when the keyboard is about to show
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
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
            if UniversalResources.KEYBOARD_VIEW_CONTROLLER_LOCATION == "AnythingLocatorViewController"
            {
                // update the height
                UniversalResources.SCROLL_AMOUNT = keyboardRectangle.height
            }
        }
        
        // if the caller is this View Controller
        if UniversalResources.KEYBOARD_VIEW_CONTROLLER_LOCATION == "AnythingLocatorViewController"
        {
            // show the keyboard is visible
            keyboardWasShown = true
        }
    }
    
    /// <summary>
    /// Called when the application is active
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func didBecomeActive(notification: NSNotification)
    {
        // if this View Controller is the top View Controller of the application
        if UniversalResources.TOP_VC == "NewCreditCardViewController"
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
                // if the caller was the building
                if pickerViewCaller == buildingCaller
                {
                    // make the Text View the current responder
                    buildingTextView.becomeFirstResponder()
                }
                    // if the caller was the floor
                else if pickerViewCaller == floorCaller
                {
                    // make the Text View the current responder
                    floorTextView.becomeFirstResponder()
                }
            }
        }
    }
    
    /// <summary>
    /// Called when the application is moving to become inactive
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func movingToInactive(notification: NSNotification)
    {
        // if this View Controller is the top View Controller of the application
        if UniversalResources.TOP_VC == "NewCreditCardViewController"
        {
            // if the Image View was set up
            if nationwideOneCoverImageView != nil
            {
                // protect the information by adding the cover View
                navigationController?.view.addSubview(nationwideOneCoverImageView)
            }
            
            // if the caller was the Credit Card number Text View
            if pickerViewCaller == buildingCaller
            {
                // to hold the value before closing the keyboard
                let keyboardWasUp = keyboardWasShown
                
                // release the responder
                buildingTextView.resignFirstResponder()
                
                // set the state before force closing
                keyboardWasShown = keyboardWasUp
            }
                // if the caller was the Credit Card month Text View
            else if pickerViewCaller == floorCaller
            {
                // to hold the value before closing the keyboard
                let keyboardWasUp = keyboardWasShown
                
                // release the responder
                floorTextView.resignFirstResponder()
                
                // set the state before force closing
                keyboardWasShown = keyboardWasUp
            }
        }
    }
    
    /// <summary>
    /// Returns the user back to the Food Menu
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func closeView(sender: UIBarButtonItem)
    {
        // dismiss View Controller
        dismissViewControllerAnimated(true){}
    }
    
    /// <summary>
    /// Updates the total price.
    /// </summary>
    /// <param name="senderButton">Sender button.</param>
    func closeKeyboardView(sender: UIButton)
    {
        // the cancel button from the tool tip
        if sender.tag == 0
        {
            // if the building Text View is the one who called the close keyboard View
            if pickerViewCaller == buildingCaller
            {
                // set the text
                buildingTextView.text = building
                
                // close the Toolbar View
                buildingTextView.resignFirstResponder()
            }
                // if the floor Text View is the one who called the close keyboard View
            else if pickerViewCaller == floorCaller
            {
                // set the text
                floorTextView.text = floor
                
                // close the Toolbar View
                floorTextView.resignFirstResponder()
            }
        }
            // the done button from the tool tip
        else if sender.tag == 1
        {
            // if the card number Text View is the one who called the close keyboard View
            if pickerViewCaller == buildingCaller
            {
                // get the building that was chosen and set the text
                let chosenBuilding = buildingPickerViewData[buildingPickerView.selectedRowInComponent(0)]
                buildingTextView.text = chosenBuilding
                
                // close the Toolbar view
                buildingTextView.resignFirstResponder()
            }
                // if the expiration month Text View is the one who called the close keyboard View
            else if pickerViewCaller == floorCaller
            {
                // get the floor that was chosen and set the text
                let chosenFloor = floorPickerViewData[floorPickerView.selectedRowInComponent(0)]
                floorTextView.text = chosenFloor
                
                // close the Toolbar view
                floorTextView.resignFirstResponder()
            }
        }
        
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
    
    
    
    
    // MARK: - all functions that relate to the internal class for the Text View Delegate
    
    /// <summary>
    /// Called when the Text View is clicked
    /// </summary>
    /// <param name="textView"> The object that called this funcion.</param>
    func textViewShouldBeginEditing(textView: UITextView) -> Bool
    {
        // if this is the building Text View
        if textView.tag == buildingTextView.tag
        {
            // set the caller
            pickerViewCaller = buildingCaller
        }
            // if this is the floor Text View
        else if textView.tag == floorTextView.tag
        {
            // set the caller
            pickerViewCaller = floorCaller
        }
        
        // show the keyboard is visible
        keyboardWasShown = true
        
        return true
    }
    
    /// <summary>
    /// Called when the Text View is moving away from being focused
    /// </summary>
    /// <param name="textView"> The object that called this funcion.</param>
    func textViewShouldEndEditing(textView: UITextView) -> Bool
    {
        // if this is the building Text View
        if textView.tag == buildingTextView.tag
        {
            // find the index of that specific building
            let index = buildingPickerViewData.indexOf(buildingTextView.text)
            
            // set the selected row
            buildingPickerView.selectRow(index!, inComponent: 0, animated: false)
        }
            // if this is the floor Text View
        else if textView.tag == floorTextView.tag
        {
            // find the index of that specific building
            let index = floorPickerViewData.indexOf(floorTextView.text)
            
            // set the selected row
            floorPickerView.selectRow(index!, inComponent: 0, animated: false)
        }
        
        // show the keyboard is no longer visible
        keyboardWasShown = false
        
        return true
    }
    
    /// <summary>
    /// Called when the Text View text changed
    /// </summary>
    /// <param name="textView"> The object that called this funcion.</param>
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        // if this is the building Text View
        if textView.tag == buildingTextView.tag
        {
            // if the user is deleting text (in this case, user selects and cuts the text)
            if text == ""
            {
                // select in Picker View data
                buildingPickerView.selectRow(0, inComponent: 0, animated: true)
            }
            else
            {
                // the potential text after insertion of new text
                let potentialText = buildingTextView.text + text
                
                // the potential index of the text attempting ot be inserted
                let index = buildingPickerViewData.indexOf(potentialText)
                
                // if the text that is trying to be inserted insint one of the following options in the picker, don't allow the change
                if index == nil
                {
                    return false
                }
                else
                {
                    // select in Picker View data
                    buildingPickerView.selectRow(index!, inComponent: 0, animated: true)
                }
            }
        }
            // if this is the floor Text View
        else if textView.tag == floorTextView.tag
        {
            // if the user is deleting text (in this case, user selects and cuts the text)
            if text == ""
            {
                // select in Picker View data
                floorPickerView.selectRow(0, inComponent: 0, animated: true)
            }
            else
            {
                // the potential text after insertion of new text
                let potentialText = floorTextView.text + text
                
                // the potential index of the text attempting ot be inserted
                let index = floorPickerViewData.indexOf(potentialText)
                
                // if the text that is trying to be inserted insint one of the following options in the picker, don't allow the change
                if index == nil
                {
                    return false
                }
                else
                {
                    // select in Picker View data
                    floorPickerView.selectRow(index!, inComponent: 0, animated: true)
                }
            }
        }
    
        return true
    }

    
    
    
    // MARK: - all functions that relate to the internal class for public accessing
    
    /// <summary>
    /// Sets up the View
    /// </summary>
    func setUpView()
    {
        // set up the navigation items
        setUpNavigationItems()
        
        // set up the tap gesture to be able to dismiss keyboard when user taps away
        tappedOffKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(AnythingLocatorViewController.tappedOffKeyboard(_:)))
        
        // add the gesture recognizer
        self.view.addGestureRecognizer(tappedOffKeyboardGesture)
        
        // set up the Image View for the View protecting image
        nationwideOneCoverImageView = UIImageView ()
        nationwideOneCoverImageView.backgroundColor = UIColor.clearColor()
        nationwideOneCoverImageView.image = nationwideOneCoverImage
        nationwideOneCoverImageView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        // set up the building and floor Views
        setUpBuildingAndFloorView()
    }
    
    
    
    
    // MARK: - all functions that relate to the internal class
    
    /// <summary>
    /// Sets up the navigation items.
    /// </summary>
    private func setUpNavigationItems()
    {
        // set up the total height needed to take account for when setting up the view
        navigationAndStatusBarHeight =  navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height
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
        backBarButtonItem = UIBarButtonItem (title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AnythingLocatorViewController.closeView(_:)))
        
        // set the left and right Bar Button Items
        navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        navigationItem.setRightBarButtonItems([] as [UIBarButtonItem], animated: true)
    }
    
    private func setUpBuildingAndFloorView()
    {
        // Read data from this file.
        let path = NSBundle.mainBundle().pathForResource("AnythingLocator", ofType: "txt")!
        
        var text: String = ""
        do
        {
            // read the Contact Us text file to create a database
            text = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding) as String
        }
        catch {}
        
        // split the text by the "\n" text
        let buildingsAndFloors = text.componentsSeparatedByString("\n")
        
        // loop through all the buildings
        for buildingAndFloors in buildingsAndFloors
        {
            let buildingAndFloorsSeperated = buildingAndFloors.componentsSeparatedByString(":")
            let floors = buildingAndFloorsSeperated[1].componentsSeparatedByString(",")
        }
        
        let width: CGFloat = 150
        let height: CGFloat = 30
        var xPos: CGFloat = view.center.x - width - 10
        let yPos: CGFloat = 10
        
        // set up the building Text View
        buildingTextView = UITextView ()
        buildingTextView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        buildingTextView.text = "Select Building"
        buildingTextView.textColor = UIColor.blackColor()
        buildingTextView.backgroundColor = UIColor.whiteColor()
        buildingTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        buildingTextView.layer.cornerRadius = 5
        buildingTextView.layer.borderWidth = 1
        buildingTextView.selectable = true
        buildingTextView.delegate = self
        buildingTextView.tag = 0

        xPos = view.center.x + 10
        // set up the floor Text View
        floorTextView = UITextView ()
        floorTextView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        floorTextView.text = "Select Year"
        floorTextView.textColor = UIColor.blackColor()
        floorTextView.backgroundColor = UIColor.whiteColor()
        floorTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        floorTextView.layer.cornerRadius = 5
        floorTextView.layer.borderWidth = 1
        floorTextView.selectable = true
        floorTextView.delegate = self
        floorTextView.tag = 1
        
        
        // set up the expiration month Picker View
        buildingPickerView = UIPickerView()
        buildingPickerViewDataSource = PickerViewDataSource()
        buildingPickerViewDataSource.pickerViewData = buildingPickerViewData
        buildingPickerViewDataSource.pickerTextView = buildingTextView
        buildingPickerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        buildingPickerView.tintColor = UIColor.blackColor()
        buildingPickerView.backgroundColor = UIColor.whiteColor()
        buildingPickerView.delegate = buildingPickerViewDataSource
        buildingPickerView.dataSource = buildingPickerViewDataSource
        
        // find the index of that specific building
        var index = buildingPickerViewData.indexOf("Select Building")
        if index == nil
        {
            index = 0
        }
        
        // set the selected row
        buildingPickerView.selectRow(index!, inComponent: 0, animated: false)
        
        
        
        // set up the expiration year Picker View
        floorPickerView = UIPickerView()
        floorPickerViewDataSource = PickerViewDataSource()
        floorPickerViewDataSource.pickerViewData = floorPickerViewData
        floorPickerViewDataSource.pickerTextView = floorTextView
        floorPickerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        floorPickerView.tintColor = UIColor.blackColor()
        floorPickerView.backgroundColor = UIColor.whiteColor()
        floorPickerView.delegate = floorPickerViewDataSource
        floorPickerView.dataSource = floorPickerViewDataSource
        
        // find the index of that specific floor
        index = floorPickerViewData.indexOf("Select Floor")
        if index == nil
        {
            index = 0
        }
        
        // set the selected row
        floorPickerView.selectRow(index!, inComponent: 0, animated: false)
        
        
        
        
        // create a Tool Bar for the done button for the Text Field keyboard
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.width, height: 44.0))
        
        // create the Tool Bar items
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        // set up the done Button
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AnythingLocatorViewController.closeKeyboardView(_:)))
        cancelButton.tintColor = UniversalResources.UI_APP_COLOR_TINT
        cancelButton.tag = 0
        
        // set up the done Button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AnythingLocatorViewController.closeKeyboardView(_:)))
        doneButton.tintColor = UniversalResources.UI_APP_COLOR_TINT
        doneButton.tag = 1
        
        // place the toolbar items in an array
        var keyboardToolBarItems = [UIBarButtonItem]()
        keyboardToolBarItems.insert(cancelButton, atIndex: keyboardToolBarItems.count)
        keyboardToolBarItems.insert(flexibleSpaceButton, atIndex: keyboardToolBarItems.count)
        keyboardToolBarItems.insert(doneButton, atIndex: keyboardToolBarItems.count)
        
        // set the keyboard toolbar items to the tool bar items of flexible space and done button
        toolbar.items = keyboardToolBarItems
        
        // set the input Views
        buildingTextView.inputAccessoryView = toolbar
        floorTextView.inputAccessoryView = toolbar
        buildingTextView.inputView = buildingPickerView
        floorTextView.inputView = floorPickerView
    }
    /// <summary>
    /// Scrolls the View.
    /// </summary>
    private func closeKeyboardIfNecessary()
    {
        // if the keyboard is currently up
        if keyboardWasShown
        {
            
            if pickerViewCaller == buildingCaller
            {
                // release the focus
                buildingTextView.resignFirstResponder()
            }
            else if pickerViewCaller == buildingCaller
            {
                // release the focus
                floorPickerView.resignFirstResponder()
            }
        }
    }
}