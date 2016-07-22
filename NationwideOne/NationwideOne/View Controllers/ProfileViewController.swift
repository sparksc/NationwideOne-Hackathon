//
//  ProfileViewController.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UITextViewDelegate
{
    // MARK: - all fields that relate to the UI View
    
    // this represent the Navigation Bar Button Item that will take the user back to the last View
    private var backBarButtonItem: UIBarButtonItem!
    
    // this represent the Navigation Bar Button Item that will allow users to edit their profile
    private var editBarButtonItem: UIBarButtonItem!
    
    // the Tap Gesture Recognizer to tell if the user tapped on any of the Views
    private var tappedOffKeyboardGesture: UITapGestureRecognizer!
    
    // the Image View that will be laid over the View to protect the information if the user minimizes the application
    private var nationwideOneCoverImageView: UIImageView!
    
    // the Image that for the cover image to protect the information
    private let nationwideOneCoverImage: UIImage = UniversalResources.NATIONWIDE_ONE_RETINA_IMAGE
    
    // the Button that will allow user to view/change their profile picture
    private var profilePictureButton: UIButton!
    
    // the Text View representing the user's full name
    private var usernameTextView: UITextView!
    
    // the Text View representing the user's work phone
    private var workPhoneTextView: UITextView!
    
    // the Text View representing the user's email
    private var emailTextView: UITextView!
    
    // the Text View representing the user's manager
    private var managerTextView: UITextView!
    
    // the Text View representing the user's title
    private var titleTextView: UITextView!
    
    // the Text View representing the user's role
    private var roleTextView: UITextView!
    
    // the Text View representing the user's location
    private var locationTextView: UITextView!
    
    // the Text View representing the user's role
    private var aboutMeTextView: UITextView!
    
    // the Text View representing the user's role
    private var specialtiesTextView: UITextView!
    
    // the Text View representing the user's role
    private var hobbiesTextView: UITextView!
    
    // the String that holds the Text View that the user has selected
    private var textViewCaller: String = ""
    
    // the String that hold the text for the about me Text View caller
    private let aboutMeCaller: String = "about me"
    
    // the String that hold the text for the specialties Text View caller
    private let specialtiesCaller: String = "specialties"
    
    // the String that hold the text for the hobbies Text View caller
    private let hobbiesCaller: String = "hobbies"
    
    // the String that hold the text for the about me
    private var aboutMe: String = ""
    
    // the String that hold the text for the specialties
    private var specialties: String = ""
    
    // the String that hold the text for the hobbies
    private var hobbies: String = ""
    
    // the Boolean that determines whether the keyboard was show when leaving the View Controller
    private var keyboardWasShown: Bool = false
    
    // the Scroll View used to control the entire View
    private var basisScrollView: UIScrollView!
    
    // the Float that holds the Scroll View position when a Text View is selected
    private var scrollViewOffsetPosition: CGPoint = CGPoint.zero
    
    // the frame size that will hold the Scroll View's origional size
    private var scrollViewOrigionalFrameSize: CGRect!
    
    
    
    
    // MARK: - all functions that relate to the View Controller super class
    
    /// <summary>
    /// The function that gets called when the View loads.
    /// </summary>
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set up a notification for when the keyboard is shown
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        // refresh the View when the notification (Moving To Inactive) happens
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProfileViewController.movingToInactive(_:)), name: "Moving To Inactive", object: nil)
        
        // refresh the View when the notification (Did Become Active) happens
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProfileViewController.didBecomeActive(_:)), name: "Did Become Active", object: nil)
        
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
        UniversalResources.TOP_VC = "PofileViewController"
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
    
    /// <summary>
    /// Called when the Text View is clicked
    /// </summary>
    /// <param name="textView"> The object that called this funcion.</param>
    func textViewShouldBeginEditing(textView: UITextView) -> Bool
    {
        // if this is the username Text View
        if textView.tag == aboutMeTextView.tag
        {
            // if the user hasn't enter their username yet
            if aboutMeTextView.text == "About Me"
            {
                // clear the text
                aboutMeTextView.text = ""
                aboutMeTextView.textColor = UIColor.blackColor()
            }
            
            // set the caller
            textViewCaller = aboutMeCaller
            
            // scroll the View to account for the keyboard
            scrollTheView(true, whichTextView: textViewCaller)
        }
            // if this is the password Text View
        else if textView.tag == specialtiesTextView.tag
        {
            // if the user hasn't enter their password yet
            if specialtiesTextView.text == "Specialties"
            {
                // clear the text
                specialtiesTextView.text = ""
                specialtiesTextView.textColor = UIColor.blackColor()
            }
            
            // set the caller
            textViewCaller = specialtiesCaller
            
            // scroll the View to account for the keyboard
            scrollTheView(true, whichTextView: textViewCaller)
        }
            // if this is the password Text View
        else if textView.tag == hobbiesTextView.tag
        {
            // if the user hasn't enter their password yet
            if hobbiesTextView.text == "Hobbies"
            {
                // clear the text
                hobbiesTextView.text = ""
                hobbiesTextView.textColor = UIColor.blackColor()
            }
            
            // set the caller
            textViewCaller = hobbiesCaller
            
            // scroll the View to account for the keyboard
            scrollTheView(true, whichTextView: textViewCaller)
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
        // if this is the username Text View
        if textView.tag == aboutMeTextView.tag
        {
            // if the current caller is this Text View (meaning user didn't switch to a new Text View before ending the origional Text View
            if textViewCaller == aboutMeCaller
            {
                // if the user didn't enter any text
                if aboutMeTextView.text == ""
                {
                    // set the text to the start value
                    aboutMeTextView.text = "About Me"
                    aboutMeTextView.textColor = UIColor.grayColor()
                }
                
                // scroll the View to account for the keyboard
                scrollTheView(false, whichTextView: textViewCaller)
            }
        }
            // if this is the password Text View
        else if textView.tag == specialtiesTextView.tag
        {
            // if the current caller is this Text View (meaning user didn't switch to a new Text View before ending the origional Text View
            if textViewCaller == specialtiesCaller
            {
                // if the user didn't enter any text
                if specialtiesTextView.text == ""
                {
                    // set the text to the start value
                    specialtiesTextView.text = "Specialties"
                    specialtiesTextView.textColor = UIColor.grayColor()
                }
                
                // scroll the View to account for the keyboard
                scrollTheView(false, whichTextView: textViewCaller)
            }
        }
            // if this is the password Text View
        else if textView.tag == hobbiesTextView.tag
        {
            // if the current caller is this Text View (meaning user didn't switch to a new Text View before ending the origional Text View
            if textViewCaller == hobbiesCaller
            {
                // if the user didn't enter any text
                if hobbiesTextView.text == ""
                {
                    // set the text to the start value
                    hobbiesTextView.text = "Hobbies"
                    hobbiesTextView.textColor = UIColor.grayColor()
                }
                
                // scroll the View to account for the keyboard
                scrollTheView(false, whichTextView: textViewCaller)
            }
        }
        
        // show the keyboard is no longer visible
        keyboardWasShown = false
        
        return true
    }
    
    /// <summary>
    /// Called when the Text View text changed
    /// </summary>
    /// <param name="textView"> The object that called this funcion.</param>
    func textView(textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        // if the content offset is not in the correct position
        if basisScrollView.contentOffset != scrollViewOffsetPosition
        {
            // set the content offset
            basisScrollView.setContentOffset (scrollViewOffsetPosition, animated: true)
        }
        
        // if this is the username Text View
        if textView.tag == aboutMeTextView.tag
        {
            // if the text that is trying to be inserted has the prefix of a newline character, end editing
            if text.hasPrefix("\n")
            {
                aboutMeTextView.endEditing(true)
                return false
            }
        }
            // if this is the password Text View
        else if textView.tag == specialtiesTextView.tag
        {
            // if the text that is trying to be inserted has the prefix of a newline character, end editing
            if text.hasPrefix("\n")
            {
                specialtiesTextView.endEditing(true)
                return false
            }
        }
            // if this is the password Text View
        else if textView.tag == hobbiesTextView.tag
        {
            // if the text that is trying to be inserted has the prefix of a newline character, end editing
            if text.hasPrefix("\n")
            {
                hobbiesTextView.endEditing(true)
                return false
            }
        }
        
        return true
    }
    
    /// <summary>
    /// Called when the Text View text is about to change
    /// </summary>
    /// <param name="textView"> The object that called this funcion.</param>
    func textViewDidChange(textView: UITextView)
    {
        // if this is the username Text View
        if textView.tag == aboutMeTextView.tag
        {
            // if user tries to submit a new line in the middle of the text
            if aboutMeTextView.text.containsString("\n")
            {
                // while there are new line characters in the string, repeat until they are all removed
                while aboutMeTextView.text.containsString("\n")
                {
                    // get the index of the new line character
                    let pos = aboutMeTextView.text.characters.indexOf("\n")
                    let posIntValue = aboutMeTextView.text.characters.startIndex.distanceTo(pos!)
                    
                    // get the first portion of the string all the way up until the new line character
                    let firstPortion = aboutMeTextView.text.substringToIndex(aboutMeTextView.text.startIndex.advancedBy(posIntValue))
                    
                    // get the second portion of the string from the new line character till the end of the string
                    let r:Range<String.Index> = (pos?.successor())! ..< aboutMeTextView.text.endIndex
                    let secondPortion = aboutMeTextView.text.substringWithRange(r)
                    
                    // set the text without the new line
                    aboutMeTextView.text = firstPortion + secondPortion
                }
            }
        }
            // if this is the password Text View
        else if textView.tag == specialtiesTextView.tag
        {
            // if user tries to submit a new line in the middle of the text
            if specialtiesTextView.text.containsString("\n")
            {
                // while there are new line characters in the string, repeat until they are all removed
                while specialtiesTextView.text.containsString("\n")
                {
                    // get the index of the new line character
                    let pos = specialtiesTextView.text.characters.indexOf("\n")
                    let posIntValue = specialtiesTextView.text.characters.startIndex.distanceTo(pos!)
                    
                    // get the first portion of the string all the way up until the new line character
                    let firstPortion = specialtiesTextView.text.substringToIndex(specialtiesTextView.text.startIndex.advancedBy(posIntValue))
                    
                    // get the second portion of the string from the new line character till the end of the string
                    let r:Range<String.Index> = (pos?.successor())! ..< specialtiesTextView.text.endIndex
                    let secondPortion = specialtiesTextView.text.substringWithRange(r)
                    
                    // set the text without the new line
                    specialtiesTextView.text = firstPortion + secondPortion
                }
            }
        }
            // if this is the password Text View
        else if textView.tag == specialtiesTextView.tag
        {
            // if user tries to submit a new line in the middle of the text
            if specialtiesTextView.text.containsString("\n")
            {
                // while there are new line characters in the string, repeat until they are all removed
                while specialtiesTextView.text.containsString("\n")
                {
                    // get the index of the new line character
                    let pos = specialtiesTextView.text.characters.indexOf("\n")
                    let posIntValue = specialtiesTextView.text.characters.startIndex.distanceTo(pos!)
                    
                    // get the first portion of the string all the way up until the new line character
                    let firstPortion = specialtiesTextView.text.substringToIndex(specialtiesTextView.text.startIndex.advancedBy(posIntValue))
                    
                    // get the second portion of the string from the new line character till the end of the string
                    let r:Range<String.Index> = (pos?.successor())! ..< specialtiesTextView.text.endIndex
                    let secondPortion = specialtiesTextView.text.substringWithRange(r)
                    
                    // set the text without the new line
                    specialtiesTextView.text = firstPortion + secondPortion
                }
            }
        }
            // if this is the password Text View
        else if textView.tag == hobbiesTextView.tag
        {
            // if user tries to submit a new line in the middle of the text
            if hobbiesTextView.text.containsString("\n")
            {
                // while there are new line characters in the string, repeat until they are all removed
                while hobbiesTextView.text.containsString("\n")
                {
                    // get the index of the new line character
                    let pos = hobbiesTextView.text.characters.indexOf("\n")
                    let posIntValue = hobbiesTextView.text.characters.startIndex.distanceTo(pos!)
                    
                    // get the first portion of the string all the way up until the new line character
                    let firstPortion = hobbiesTextView.text.substringToIndex(hobbiesTextView.text.startIndex.advancedBy(posIntValue))
                    
                    // get the second portion of the string from the new line character till the end of the string
                    let r:Range<String.Index> = (pos?.successor())! ..< hobbiesTextView.text.endIndex
                    let secondPortion = hobbiesTextView.text.substringWithRange(r)
                    
                    // set the text without the new line
                    hobbiesTextView.text = firstPortion + secondPortion
                }
            }
        }
    }

    
    
    // MARK: - all functions that relate to the objects that calls these functions through an action
    
    /// <summary>
    /// Returns the user back to the Food Menu
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func closeView(sender: UIBarButtonItem)
    {
        // dismiss this View Controller
        dismissViewControllerAnimated (true) {
            // go back to View Controller that this View Controller was called from
        }
    }

    /// <summary>
    /// Let's user begin editing.
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func editProfile(sender: UIBarButtonItem)
    {
        if navigationItem.rightBarButtonItems?[0].title == "Edit"
        {
            // set the editable rights
            aboutMeTextView.editable = true
            specialtiesTextView.editable = true
            hobbiesTextView.editable = true
            
            // set a new text to the Bar Button Items
            navigationItem.rightBarButtonItems?[0].title = "Done"
            
            // go into edit mode
            aboutMeTextView.becomeFirstResponder()
        }
        else if navigationItem.rightBarButtonItems?[0].title == "Done"
        {
            // set the editable rights
            aboutMeTextView.editable = false
            specialtiesTextView.editable = false
            hobbiesTextView.editable = false
            
            // set a new text to the Bar Button Items
            navigationItem.rightBarButtonItems?[0].title = "Edit"
        }
    }
    
    /// <summary>
    /// Let's user choose what to do with their profile picture.
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func editProfilePicture(sender: UIButton)
    {
        // create the AlertController for switching payment type
        let alertController: UIAlertController = UIAlertController(title: "What do you want to do?", message: "", preferredStyle: .ActionSheet)
        alertController.view.tintColor = UniversalResources.UI_APP_COLOR_TINT
        
        // create and add the "Cash" action
        let viewAction: UIAlertAction = UIAlertAction(title: "View Picture", style: .Default) { action -> Void in
            
        }
        
        // create and add the "Credit Card" action
        let editAction: UIAlertAction = UIAlertAction(title: "Edit Picture", style: .Default) { action -> Void in
 
        }
        
        // add the actions
        alertController.addAction(viewAction)
        alertController.addAction(editAction)
        
        // present the AlertController
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
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
            if UniversalResources.KEYBOARD_VIEW_CONTROLLER_LOCATION == "ProfileViewController"
            {
                // update the height
                UniversalResources.SCROLL_AMOUNT = keyboardRectangle.height
                
                // scroll the View again to update changes
                scrollTheView(true, whichTextView: textViewCaller)
            }
        }
        
        // if the caller is this View Controller
        if UniversalResources.KEYBOARD_VIEW_CONTROLLER_LOCATION == "ProfileViewController"
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
                // if the caller was the about me Text View
                if textViewCaller == aboutMeCaller
                {
                    // make the Text View the current responder
                    aboutMeTextView.becomeFirstResponder()
                }
                // if the caller was the specialties Text View
                else if textViewCaller == specialtiesCaller
                {
                    // make the Text View the current responder
                    specialtiesTextView.becomeFirstResponder()
                }
                    // if the caller was the specialties Text View
                else if textViewCaller == hobbiesCaller
                {
                    // make the Text View the current responder
                    hobbiesTextView.becomeFirstResponder()
                }
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
            
            // if the caller was the username Text View
            if textViewCaller == aboutMeCaller
            {
                // to hold the value before closing the keyboard
                let keyboardWasUp = keyboardWasShown
                
                // release the responder
                aboutMeTextView.resignFirstResponder()
                
                // scroll the View
                scrollTheView(false, whichTextView: textViewCaller)
                
                // set the state before force closing
                keyboardWasShown = keyboardWasUp
            }
                // if the caller was the password Text View
            else if textViewCaller == specialtiesCaller
            {
                // to hold the value before closing the keyboard
                let keyboardWasUp = keyboardWasShown
                
                // release the responder
                specialtiesTextView.resignFirstResponder()
                
                // scroll the View
                scrollTheView(false, whichTextView: textViewCaller)
                
                // set the state before force closing
                keyboardWasShown = keyboardWasUp
            }
                // if the caller was the password Text View
            else if textViewCaller == hobbiesCaller
            {
                // to hold the value before closing the keyboard
                let keyboardWasUp = keyboardWasShown
                
                // release the responder
                hobbiesTextView.resignFirstResponder()
                
                // scroll the View
                scrollTheView(false, whichTextView: textViewCaller)
                
                // set the state before force closing
                keyboardWasShown = keyboardWasUp
            }
        }
    }
    
    /// <summary>
    /// Closes keyboard View.
    /// </summary>
    /// <param name="sender">Sender button.</param>
    func closeKeyboardView(sender: UIButton)
    {
        // the cancel button from the tool tip
        if sender.tag == 0
        {
            // if the username Text View is the one who called the close keyboard View
            if textViewCaller == aboutMeCaller
            {
                // set the previous username value
                aboutMeTextView.text = aboutMe
                
                // close the Toolbar View
                aboutMeTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
            }
                // if the password Text View is the one who called the close keyboard View
            else if textViewCaller == specialtiesCaller
            {
                // set the previous username value
                specialtiesTextView.text = specialties
                
                // close the Toolbar View
                specialtiesTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
            }
                // if the password Text View is the one who called the close keyboard View
            else if textViewCaller == hobbiesCaller
            {
                // set the previous username value
                hobbiesTextView.text = hobbies
                
                // close the Toolbar View
                hobbiesTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
            }
        }
            // the done button from the tool tip
        else if sender.tag == 1
        {
            // if the username Text View is the one who called the close keyboard View
            if textViewCaller == aboutMeCaller
            {
                // set the username
                aboutMe = aboutMeTextView.text
                
                // close the Toolbar view
                aboutMeTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
            }
                // if the password Text View is the one who called the close keyboard View
            else if textViewCaller == specialtiesCaller
            {
                // set the password
                specialties = specialtiesTextView.text
                
                // close the Toolbar view
                specialtiesTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
            }
                // if the password Text View is the one who called the close keyboard View
            else if textViewCaller == hobbiesCaller
            {
                // set the password
                hobbies = hobbiesTextView.text
                
                // close the Toolbar view
                hobbiesTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
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

    
    
    
    
    // MARK: - all functions that relate to the internal class for public accessing
    
    /// <summary>
    /// Sets up the navigation items.
    /// </summary>
    func setUpView()
    {
        // set up the navigation items
        setUpNavigationItems()
        
        // set up the tap gesture to be able to dismiss keyboard when user taps away
        tappedOffKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.tappedOffKeyboard(_:)))
        
        
        // add the gesture recognizer
        self.view.addGestureRecognizer(tappedOffKeyboardGesture)
        
        // set up the Image View for the View protecting image
        nationwideOneCoverImageView = UIImageView ()
        nationwideOneCoverImageView.backgroundColor = UIColor.clearColor()
        nationwideOneCoverImageView.image = nationwideOneCoverImage
        nationwideOneCoverImageView.frame = CGRect(x: 0, y: 0.0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        // set up the Scroll View and the attributes
        basisScrollView = UIScrollView (frame: CGRect (x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        // set up Profile Picture View
        setUpProfilePictureView()
        
        // set up the non editable Text Views
        setUpNonEditableTextViews()
        
        // set up the editable Text Views
        setUpEditableTextViews()
        
        // will hold the content height of the Scroll View
        let contentHeight = hobbiesTextView.frame.origin.y + hobbiesTextView.frame.height

        // set up the Scroll View
        basisScrollView.backgroundColor = view.backgroundColor
        basisScrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight)
        basisScrollView.frame = CGRect (x: 0, y: 0, width: view.frame.width, height: contentHeight)
        scrollViewOrigionalFrameSize = basisScrollView.frame
        
        // add the View
        view.addSubview(basisScrollView)
    }

    
    
    // MARK: - all functions that relate to the internal class
    
    /// <summary>
    /// Sets up the navigation items.
    /// </summary>
    private func setUpNavigationItems()
    {
        // set up a tmp view
        let tmpImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        tmpImageView.image = UniversalResources.LOGO_TOP_BAR_IMAGE
        
        // set up the attributes of the navigation controller
        navigationController?.navigationBar.barTintColor = UniversalResources.UI_APP_COLOR_TINT
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBarHidden = false
        navigationItem.titleView = tmpImageView
        
        // set up the back Bar Button Item
        backBarButtonItem = UIBarButtonItem (title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ProfileViewController.closeView(_:)))
        
        // set up the edit Bar Button Item
        editBarButtonItem = UIBarButtonItem (title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ProfileViewController.editProfile(_:)))
        
        // set the left and right Bar Button Items
        navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        navigationItem.rightBarButtonItems?.removeAll()
        navigationItem.setRightBarButtonItem(editBarButtonItem, animated: true)
    }

    /// <summary>
    /// Sets up the profile picture view.
    /// </summary>
    private func setUpProfilePictureView()
    {
        // set up the profile Button
        let xPos = view.center.x - 25
        profilePictureButton = UIButton ()
        profilePictureButton.setImage(UniversalResources.PROFILE_IMAGE, forState: UIControlState.Normal)
        profilePictureButton.backgroundColor = UIColor.clearColor()
        profilePictureButton.frame = CGRect(x: xPos, y: 10, width: 50, height: 50)
        profilePictureButton.addTarget(self, action: #selector(ProfileViewController.editProfilePicture(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // add the View
        basisScrollView.addSubview(profilePictureButton)
    }
    
    /// <summary>
    /// Sets up the non editable Text Views.
    /// </summary>
    private func setUpNonEditableTextViews()
    {
        // width and height
        let width: CGFloat = 150
        let height: CGFloat = 30
        
        // y position
        var yPos: CGFloat = profilePictureButton.frame.origin.y + profilePictureButton.frame.height + 5
        var xPos: CGFloat = view.center.x - width - 5
        
        // set up a frame size for the Text View
        var frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        usernameTextView = UITextView (frame: frameSize)
        usernameTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        usernameTextView.text = UniversalResources.SIGNED_IN_PROFILE.name
        usernameTextView.textColor = UIColor.lightGrayColor()
        usernameTextView.tintColor = UIColor.blackColor()
        usernameTextView.backgroundColor = UIColor.grayColor()
        usernameTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        usernameTextView.layer.cornerRadius = 5
        usernameTextView.layer.borderWidth = 1
        usernameTextView.selectable = true
        usernameTextView.editable = false
        usernameTextView.delegate = self
        usernameTextView.tag = 0
        
        xPos = usernameTextView.frame.origin.x + usernameTextView.frame.width + 5
        frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        workPhoneTextView = UITextView (frame: frameSize)
        workPhoneTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        workPhoneTextView.text = UniversalResources.SIGNED_IN_PROFILE.workPhone
        workPhoneTextView.textColor = UIColor.lightGrayColor()
        workPhoneTextView.tintColor = UIColor.blackColor()
        workPhoneTextView.backgroundColor = UIColor.grayColor()
        workPhoneTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        workPhoneTextView.layer.cornerRadius = 5
        workPhoneTextView.layer.borderWidth = 1
        workPhoneTextView.selectable = true
        workPhoneTextView.editable = false
        workPhoneTextView.delegate = self
        workPhoneTextView.tag = 1
        
        xPos = view.center.x - width - 5
        yPos = usernameTextView.frame.origin.y + usernameTextView.frame.height + 5
        frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        emailTextView = UITextView (frame: frameSize)
        emailTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        emailTextView.text = UniversalResources.SIGNED_IN_PROFILE.workEmail
        emailTextView.textColor = UIColor.lightGrayColor()
        emailTextView.tintColor = UIColor.blackColor()
        emailTextView.backgroundColor = UIColor.grayColor()
        emailTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        emailTextView.layer.cornerRadius = 5
        emailTextView.layer.borderWidth = 1
        emailTextView.selectable = true
        emailTextView.editable = false
        emailTextView.delegate = self
        emailTextView.tag = 2
        
        xPos = emailTextView.frame.origin.x + emailTextView.frame.width + 5
        frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        managerTextView = UITextView (frame: frameSize)
        managerTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        managerTextView.text = UniversalResources.SIGNED_IN_PROFILE.manager
        managerTextView.textColor = UIColor.lightGrayColor()
        managerTextView.tintColor = UIColor.blackColor()
        managerTextView.backgroundColor = UIColor.grayColor()
        managerTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        managerTextView.layer.cornerRadius = 5
        managerTextView.layer.borderWidth = 1
        managerTextView.selectable = true
        managerTextView.editable = false
        managerTextView.delegate = self
        managerTextView.tag = 3
        
        xPos = view.center.x - width - 5
        yPos = emailTextView.frame.origin.y + emailTextView.frame.height + 5
        frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        titleTextView = UITextView (frame: frameSize)
        titleTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        titleTextView.text = UniversalResources.SIGNED_IN_PROFILE.title
        titleTextView.textColor = UIColor.lightGrayColor()
        titleTextView.tintColor = UIColor.blackColor()
        titleTextView.backgroundColor = UIColor.grayColor()
        titleTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        titleTextView.layer.cornerRadius = 5
        titleTextView.layer.borderWidth = 1
        titleTextView.selectable = true
        titleTextView.editable = false
        titleTextView.delegate = self
        titleTextView.tag = 4
        
        xPos = titleTextView.frame.origin.x + titleTextView.frame.width + 5
        frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        roleTextView = UITextView (frame: frameSize)
        roleTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        roleTextView.text = UniversalResources.SIGNED_IN_PROFILE.role
        roleTextView.textColor = UIColor.lightGrayColor()
        roleTextView.tintColor = UIColor.blackColor()
        roleTextView.backgroundColor = UIColor.grayColor()
        roleTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        roleTextView.layer.cornerRadius = 5
        roleTextView.layer.borderWidth = 1
        roleTextView.selectable = true
        roleTextView.editable = false
        roleTextView.delegate = self
        roleTextView.tag = 5
        
        yPos = roleTextView.frame.origin.y + roleTextView.frame.height + 5
        xPos = view.center.x - width/2
        frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        locationTextView = UITextView (frame: frameSize)
        locationTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        locationTextView.text = UniversalResources.SIGNED_IN_PROFILE.location
        locationTextView.textColor = UIColor.lightGrayColor()
        locationTextView.tintColor = UIColor.blackColor()
        locationTextView.backgroundColor = UIColor.grayColor()
        locationTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        locationTextView.layer.cornerRadius = 5
        locationTextView.layer.borderWidth = 1
        locationTextView.selectable = true
        locationTextView.editable = false
        locationTextView.delegate = self
        locationTextView.tag = 6
        
        // add the Views
        basisScrollView.addSubview(usernameTextView)
        basisScrollView.addSubview(workPhoneTextView)
        basisScrollView.addSubview(emailTextView)
        basisScrollView.addSubview(managerTextView)
        basisScrollView.addSubview(titleTextView)
        basisScrollView.addSubview(roleTextView)
        basisScrollView.addSubview(locationTextView)
    }
    
    /// <summary>
    /// Sets up the non editable Text Views.
    /// </summary>
    private func setUpEditableTextViews()
    {
        // width and height
        let width: CGFloat = view.frame.width/2
        let height: CGFloat = 30
        
        // x and y position
        var yPos: CGFloat = locationTextView.frame.origin.y + locationTextView.frame.height + 10
        var xPos: CGFloat = view.center.x - width/2
        
        // set up a frame size for the Text View
        var frameSize = CGRect(x: xPos, y: yPos, width: width, height: 60)
        
        // set up the Text View and the attributes
        aboutMeTextView = UITextView (frame: frameSize)
        aboutMeTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        aboutMeTextView.text = UniversalResources.SIGNED_IN_PROFILE.aboutMe
        aboutMeTextView.textColor = UIColor.lightGrayColor()
        aboutMeTextView.tintColor = UIColor.blackColor()
        aboutMeTextView.backgroundColor = UIColor.whiteColor()
        aboutMeTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        aboutMeTextView.layer.cornerRadius = 5
        aboutMeTextView.layer.borderWidth = 1
        aboutMeTextView.selectable = true
        aboutMeTextView.editable = false
        aboutMeTextView.delegate = self
        aboutMeTextView.tag = 7
        
        xPos = view.center.x - width/2
        yPos = aboutMeTextView.frame.origin.y + aboutMeTextView.frame.height + 5
        frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        specialtiesTextView = UITextView (frame: frameSize)
        specialtiesTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        specialtiesTextView.text = UniversalResources.SIGNED_IN_PROFILE.specialties
        specialtiesTextView.textColor = UIColor.lightGrayColor()
        specialtiesTextView.tintColor = UIColor.blackColor()
        specialtiesTextView.backgroundColor = UIColor.whiteColor()
        specialtiesTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        specialtiesTextView.layer.cornerRadius = 5
        specialtiesTextView.layer.borderWidth = 1
        specialtiesTextView.selectable = true
        specialtiesTextView.editable = false
        specialtiesTextView.delegate = self
        specialtiesTextView.tag = 8
        
        xPos = view.center.x - width/2
        yPos = specialtiesTextView.frame.origin.y + specialtiesTextView.frame.height + 5
        frameSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // set up the Text View and the attributes
        hobbiesTextView = UITextView (frame: frameSize)
        hobbiesTextView.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        hobbiesTextView.text = UniversalResources.SIGNED_IN_PROFILE.hobbies
        hobbiesTextView.textColor = UIColor.lightGrayColor()
        hobbiesTextView.tintColor = UIColor.blackColor()
        hobbiesTextView.backgroundColor = UIColor.whiteColor()
        hobbiesTextView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        hobbiesTextView.layer.cornerRadius = 5
        hobbiesTextView.layer.borderWidth = 1
        hobbiesTextView.selectable = true
        hobbiesTextView.editable = false
        hobbiesTextView.delegate = self
        hobbiesTextView.tag = 9
        
        // add the Views
        basisScrollView.addSubview(aboutMeTextView)
        basisScrollView.addSubview(specialtiesTextView)
        basisScrollView.addSubview(hobbiesTextView)
    }

    /// <summary>
    /// Scrolls the View.
    /// </summary>
    private func closeKeyboardIfNecessary()
    {
        // if the keyboard is currently up
        if keyboardWasShown
        {
            // if the username Text View is the current caller
            if textViewCaller == aboutMeCaller
            {
                // set the previous text value
                aboutMeTextView.text = aboutMe
                
                // release the focus
                aboutMeTextView.resignFirstResponder()
            }
                // if the password Text View is the current caller
            else if textViewCaller == specialtiesCaller
            {
                // set the previous text value
                specialtiesTextView.text = specialties
                
                // release the focus
                specialtiesTextView.resignFirstResponder()
            }
                // if the password Text View is the current caller
            else if textViewCaller == hobbiesCaller
            {
                // set the previous text value
                hobbiesTextView.text = hobbies
                
                // release the focus
                hobbiesTextView.resignFirstResponder()
            }
        }
    }

    /// <summary>
    /// Scrolls the view.
    /// </summary>
    /// <param name="scroll">If set to <c>true</c> scroll.</param>
    /// <param name="whichTextView">The Text View to scroll.</param>
    private func scrollTheView(scroll: Bool, whichTextView: String)
    {
        // set up the animations attributes
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(UniversalResources.SCROLL_ANIMATION_DURATION)
        UIView.setAnimationCurve(UniversalResources.SCROLL_ANIMATION_CURVE)
        
        // if the view needs to scroll
        if scroll
        {
            // if the Scroll View is not set to the origional frame size, reset it
            if basisScrollView.frame != scrollViewOrigionalFrameSize
            {
                basisScrollView.frame = scrollViewOrigionalFrameSize
            }
            
            // get the needed height for the Scroll View
            let height = view.frame.height - UniversalResources.SCROLL_AMOUNT
            
            // set the frame
            basisScrollView.frame = CGRect(x: 0, y: 0, width: basisScrollView.frame.width, height: height)
            
            // if the Text View needed to scroll for is the username Text View
            if whichTextView == aboutMeCaller
            {
                // get the bottom position from the username Text View
                let bottom = aboutMeTextView.frame.origin.y + aboutMeTextView.frame.height - height
                
                // if the bottom position is greater than zero, the content offset needs to be adjusted
                if(bottom > 0)
                {
                    basisScrollView.setContentOffset (CGPoint (x: 0, y: bottom), animated: true)
                    scrollViewOffsetPosition = CGPoint (x: 0, y: bottom)
                }
            }
                // if the Text View needed to scroll for is the password Text View
            else if whichTextView == specialtiesCaller
            {
                // get the bottom position from the username Text View
                let bottom = specialtiesTextView.frame.origin.y + specialtiesTextView.frame.height - height
                
                // if the bottom position is greater than zero, the content offset needs to be adjusted
                if(bottom > 0)
                {
                    basisScrollView.setContentOffset (CGPoint (x: 0, y: bottom), animated: true)
                    scrollViewOffsetPosition = CGPoint (x: 0, y: bottom)
                }
            }
                // if the Text View needed to scroll for is the password Text View
            else if whichTextView == hobbiesCaller
            {
                // get the bottom position from the username Text View
                let bottom = hobbiesTextView.frame.origin.y + hobbiesTextView.frame.height - height
                
                // if the bottom position is greater than zero, the content offset needs to be adjusted
                if(bottom > 0)
                {
                    basisScrollView.setContentOffset (CGPoint (x: 0, y: bottom), animated: true)
                    scrollViewOffsetPosition = CGPoint (x: 0, y: bottom)
                }
            }
        }
        else
        {
            // set the frame size back to normal
            basisScrollView.frame = scrollViewOrigionalFrameSize
            basisScrollView.setContentOffset (CGPoint (x: 0, y: 0), animated: true)
            scrollViewOffsetPosition = CGPoint (x: 0, y: 0)
        }
        
        // commit the animations
        UIView.commitAnimations()
    }
}