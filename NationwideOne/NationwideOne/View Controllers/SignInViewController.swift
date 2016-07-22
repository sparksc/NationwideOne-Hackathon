//
//  SignInViewController.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class SignInViewController: UIViewController, UITextViewDelegate
{
    // MARK: - all fields that relate to the UI View
    
    // the Tap Gesture Recognizer to tell if the user tapped on any of the Views
    private var tappedOffKeyboardGesture: UITapGestureRecognizer!
    
    // the CGFloat that will contain the total height of the navigation bar and status bar
    private var navigationAndStatusBarHeight: CGFloat = 64
    
    // the Float that holds the Scroll View position when a Text View is selected
    private var scrollViewOffsetPosition: CGPoint = CGPoint.zero
    
    // the frame size that will hold the Scroll View's origional size
    private var scrollViewOrigionalFrameSize: CGRect!
    
    // the Label that will display a text to ask users if they want to be remembered
    private var rememberMeLabel: UILabel!
    
    // the Button that will display a blur View over the screen
    private var blurEffectButton: UIButton!
    
    // the Button that will display a blur View over the Navigation Bar
    private var blurEffectButton2: UIButton!
    
    // the Button that will used to allow the user to sign in with correct credentials
    private var signInButton: UIButton!
    
    // the Button that users can select to remeber them for next time of logging in
    private var rememberMeButton: UIButton!
    
    // the Text View representing the username
    private var usernameTextView: UITextView!
    
    // the Text View representing the password
    private var passwordTextView: UITextView!
    
    // the Image View that will be laid over the View to protect the information if the user minimizes the application
    private var nationwideOneCoverImageView: UIImageView!
    
    // the Image View used to display the application name as the background
    private var nationwideOneImageView: UIImageView!
    
    // the Image that for the cover image to protect the information
    private let nationwideOneCoverImage: UIImage = UniversalResources.NATIONWIDE_ONE_RETINA_IMAGE
    
    // the Image that for the application name as the background
    private let nationwideOneImage: UIImage = UniversalResources.NATIONWIDE_ONE_BLUE_BACKGROUND_IMAGE
    
    // the String that holds the Text View that the user has selected
    private var textViewCaller: String = ""
    
    // the String that hold the text for the username Text View caller
    private let usernameCaller: String = "username"
    
    // the String that hold the text for the password Text View caller
    private let passwordCaller: String = "password"
    
    // the String that hold the text for the username
    private var username: String = ""
    
    // the String that hold the text for the password
    private var password: String = ""
    
    // the Boolean that determines whether the keyboard was show when leaving the View Controller
    private var keyboardWasShown: Bool = false
    
    // the Scroll View used to control the entire View
    private var basisScrollView: UIScrollView!
    

    
    
    // MARK: - all functions that relate to the View Controller super class
    
    /// <summary>
    /// The function that gets called when the View loads.
    /// </summary>
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set up a notification for when the keyboard is shown
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignInViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        // refresh the View when the notification (Moving To Inactive) happens
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignInViewController.movingToInactive(_:)), name: "Moving To Inactive", object: nil)
        
        // refresh the View when the notification (Did Become Active) happens
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignInViewController.didBecomeActive(_:)), name: "Did Become Active", object: nil)

        
        // set the status bar style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        // update the status bar style
        self.setNeedsStatusBarAppearanceUpdate()
        
        // sets up the View to not extend under navigation bar top
        self.edgesForExtendedLayout = UIRectEdge()
        
        // read cache file
        readCache()
        
        // set up the View
        setUpView()
    }
    
    /// <summary>
    /// The function that gets called when the View will appear.
    /// </summary>
    /// <param name="animated">If set to <c>true</c> animated.</param>
    override func viewWillAppear (animated: Bool)
    {
        super.viewWillAppear (animated)
        
        // set the top View Controller
        UniversalResources.TOP_VC = "SignInViewController"
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
        return true
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
    /// Sign's in to the user's account.
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func signIn(sender: UIButton)
    {
        // if the sign in Button is pressed
        if sender.tag == signInButton.tag
        {
            UniversalResources.SIGNED_IN_PROFILE = UserProfile.findUserProfileByShortName(usernameTextView.text)
            
            // set up Side Menu database
            UniversalResources.setUpSideMenuDatabase ()
            
            /*
            // set up Contact Us issue database
            UniversalResources.setUpContactUsDatabase ()
            
            // set up Contact Us charges issue database
            UniversalResources.setUpContactUsChargesIssuesDatabase()
            */
            
            // create an animation for loading the view
            // for presenting instatiate the View Controller
            let loadingAlertViewController = UniversalResources.STORYBOARD.instantiateViewControllerWithIdentifier("LoadingAlertViewController") as! LoadingAlertViewController
            loadingAlertViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            loadingAlertViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            
            // present View controller
            self.presentViewController (loadingAlertViewController, animated: true, completion: nil)
            
            // set up the View
            loadingAlertViewController.setUpStyleOneView()
            
            // if the user chose to save their username/password
            if rememberMeButton.currentImage == UniversalResources.CIRCLE_CHECK_APP_COLOR_IMAGE
            {
                // open cache file and save username and password
                writeCache()
            }
            
            // give a little animation by delaying the update
            var time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue())
            {
                // close the View
                loadingAlertViewController.closeView()
                
                // give a little animation by delaying the update
                time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(0.5 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue())
                {
                    // for presenting instatiate the View Controller
                    let homeViewController = UniversalResources.STORYBOARD.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
                    
                    // push the View Controller and set up the View
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                    homeViewController.setUpView()
                }
            }
        }
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
            if UniversalResources.KEYBOARD_VIEW_CONTROLLER_LOCATION == "SignInViewController"
            {
                // update the height
                UniversalResources.SCROLL_AMOUNT = keyboardRectangle.height
                
                // scroll the View again to update changes
                scrollTheView(true, whichTextView: textViewCaller)
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
                // if the caller was the username Text View
                if textViewCaller == usernameCaller
                {
                    // make the Text View the current responder
                    usernameTextView.becomeFirstResponder()
                }
                    // if the caller was the password Text View
                else if textViewCaller == passwordCaller
                {
                    // make the Text View the current responder
                    passwordTextView.becomeFirstResponder()
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
            if textViewCaller == usernameCaller
            {
                // to hold the value before closing the keyboard
                let keyboardWasUp = keyboardWasShown
                
                // release the responder
                usernameTextView.resignFirstResponder()
                
                // scroll the View
                scrollTheView(false, whichTextView: textViewCaller)
                
                // set the state before force closing
                keyboardWasShown = keyboardWasUp
            }
                // if the caller was the password Text View
            else if textViewCaller == passwordCaller
            {
                // to hold the value before closing the keyboard
                let keyboardWasUp = keyboardWasShown
                
                // release the responder
                passwordTextView.resignFirstResponder()
                
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
            if textViewCaller == usernameCaller
            {
                // set the previous username value
                usernameTextView.text = username
                
                // close the Toolbar View
                usernameTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
            }
                // if the password Text View is the one who called the close keyboard View
            else if textViewCaller == passwordCaller
            {
                // set the previous username value
                passwordTextView.text = password
                
                // close the Toolbar View
                passwordTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
            }
        }
            // the done button from the tool tip
        else if sender.tag == 1
        {
            // if the username Text View is the one who called the close keyboard View
            if textViewCaller == usernameCaller
            {
                // set the username
                username = usernameTextView.text
                
                // close the Toolbar view
                usernameTextView.resignFirstResponder()
                scrollTheView(false, whichTextView: textViewCaller)
            }
                // if the password Text View is the one who called the close keyboard View
            else if textViewCaller == passwordCaller
            {
                // set the password
                password = passwordTextView.text
                
                // close the Toolbar view
                passwordTextView.resignFirstResponder()
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
    
    /// <summary>
    /// Called when the save Button changes state
    /// </summary>
    /// <param name="sender"> The object that called this funcion.</param>
    func buttonStateChanged(sender: UIButton)
    {
        // if the didn't check the box
        if sender.currentImage == UniversalResources.UNCHECKED_CHECK_BOX_IMAGE
        {
            // set the image to selected
            rememberMeButton.setImage(UniversalResources.CHECKED_CHECK_BOX_IMAGE, forState: UIControlState.Normal)
        }
        else
        {
            // set the image to selected
            rememberMeButton.setImage(UniversalResources.UNCHECKED_CHECK_BOX_IMAGE, forState: UIControlState.Normal)
        }
    }
    
    
    
    // MARK: - all functions that relate to the internal class for the Text View Delegate
    
    /// <summary>
    /// Called when the Text View is clicked
    /// </summary>
    /// <param name="textView"> The object that called this funcion.</param>
    func textViewShouldBeginEditing(textView: UITextView) -> Bool
    {
        // if this is the username Text View
        if textView.tag == usernameTextView.tag
        {
            // if the user hasn't enter their username yet
            if usernameTextView.text == "Username"
            {
                // clear the text
                usernameTextView.text = ""
                usernameTextView.textColor = UIColor.blackColor()
            }
            
            // set the caller
            textViewCaller = usernameCaller
            
            // scroll the View to account for the keyboard
            scrollTheView(true, whichTextView: textViewCaller)
        }
            // if this is the password Text View
        else if textView.tag == passwordTextView.tag
        {
            // if the user hasn't enter their password yet
            if passwordTextView.text == "Username"
            {
                // clear the text
                passwordTextView.text = ""
                passwordTextView.textColor = UIColor.blackColor()
            }
            
            // set the caller
            textViewCaller = passwordCaller
            
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
        if textView.tag == usernameTextView.tag
        {
            // if the current caller is this Text View (meaning user didn't switch to a new Text View before ending the origional Text View
            if textViewCaller == usernameCaller
            {
                // if the user didn't enter any text
                if usernameTextView.text == ""
                {
                    // set the text to the start value
                    usernameTextView.text = "Username"
                    usernameTextView.textColor = UIColor.grayColor()
                }

                // scroll the View to account for the keyboard
                scrollTheView(false, whichTextView: textViewCaller)
            }
        }
            // if this is the password Text View
        else if textView.tag == passwordTextView.tag
        {
            // if the current caller is this Text View (meaning user didn't switch to a new Text View before ending the origional Text View
            if textViewCaller == passwordCaller
            {
                // if the user didn't enter any text
                if passwordTextView.text == ""
                {
                    // set the text to the start value
                    passwordTextView.text = "Password"
                    passwordTextView.textColor = UIColor.grayColor()
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
        if textView.tag == usernameTextView.tag
        {
            // if the text that is trying to be inserted has the prefix of a newline character, end editing
            if text.hasPrefix("\n")
            {
                usernameTextView.endEditing(true)
                return false
            }
        }
            // if this is the password Text View
        else if textView.tag == passwordTextView.tag
        {
            // if the text that is trying to be inserted has the prefix of a newline character, end editing
            if text.hasPrefix("\n")
            {
                usernameTextView.endEditing(true)
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
        if textView.tag == usernameTextView.tag
        {
            // if user tries to submit a new line in the middle of the text
            if usernameTextView.text.containsString("\n")
            {
                // while there are new line characters in the string, repeat until they are all removed
                while usernameTextView.text.containsString("\n")
                {
                    // get the index of the new line character
                    let pos = usernameTextView.text.characters.indexOf("\n")
                    let posIntValue = usernameTextView.text.characters.startIndex.distanceTo(pos!)
                    
                    // get the first portion of the string all the way up until the new line character
                    let firstPortion = usernameTextView.text.substringToIndex(usernameTextView.text.startIndex.advancedBy(posIntValue))
                    
                    // get the second portion of the string from the new line character till the end of the string
                    let r:Range<String.Index> = (pos?.successor())! ..< usernameTextView.text.endIndex
                    let secondPortion = usernameTextView.text.substringWithRange(r)
                    
                    // set the text without the new line
                    usernameTextView.text = firstPortion + secondPortion
                }
            }
        }
            // if this is the password Text View
        else if textView.tag == passwordTextView.tag
        {
            // if user tries to submit a new line in the middle of the text
            if passwordTextView.text.containsString("\n")
            {
                // while there are new line characters in the string, repeat until they are all removed
                while passwordTextView.text.containsString("\n")
                {
                    // get the index of the new line character
                    let pos = passwordTextView.text.characters.indexOf("\n")
                    let posIntValue = passwordTextView.text.characters.startIndex.distanceTo(pos!)
                    
                    // get the first portion of the string all the way up until the new line character
                    let firstPortion = passwordTextView.text.substringToIndex(passwordTextView.text.startIndex.advancedBy(posIntValue))
                    
                    // get the second portion of the string from the new line character till the end of the string
                    let r:Range<String.Index> = (pos?.successor())! ..< passwordTextView.text.endIndex
                    let secondPortion = passwordTextView.text.substringWithRange(r)
                    
                    // set the text without the new line
                    passwordTextView.text = firstPortion + secondPortion
                }
            }
        }
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
        tappedOffKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.tappedOffKeyboard(_:)))
        
        
        // add the gesture recognizer
        self.view.addGestureRecognizer(tappedOffKeyboardGesture)
        
        // set up the Image View for the View protecting image
        nationwideOneCoverImageView = UIImageView ()
        nationwideOneCoverImageView.backgroundColor = UIColor.clearColor()
        nationwideOneCoverImageView.image = nationwideOneCoverImage
        nationwideOneCoverImageView.frame = CGRect(x: 0, y: 0.0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        // set up the Scroll View and the attributes
        basisScrollView = UIScrollView (frame: CGRect (x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        // set up the background View
        setUpNationwideOneImageView ()
        
        // set up the username/password View
        setUpUsernamePasswordView ()
        
        // setup the remember me View
        setUpRememberMe ()
        
        // set up the sign in Button
        setUpSignInButton ()
        
        
        // will hold the content height of the Scroll View
        let contentHeight = signInButton.frame.origin.y + signInButton.frame.height
        
        // set up the Scroll View
        basisScrollView.backgroundColor = view.backgroundColor
        basisScrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight)
        basisScrollView.frame = CGRect (x: 0, y: 0, width: view.frame.width, height: contentHeight)
        scrollViewOrigionalFrameSize = basisScrollView.frame
        
        // add the Scroll View to the View
        view.addSubview (basisScrollView)
        
        // authenticate the user if using Touch ID
        authenticateUser()
    }
    
    
    
    // MARK: - all functions that relate to the internal class
    
    /// <summary>
    /// Reads cache.
    /// </summary>
    private func readCache()
    {
        // open up the cache and read the data
        // Read data from this file.
        let path = NSBundle.mainBundle().pathForResource("cache", ofType: "txt")!
        
        var text: String = ""
        do
        {
            // read the Contact Us text file to create a database
            text = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding) as String
        }
        catch {}
        
        // split the text by the "Profile~" text
        let usernameInfo = text.componentsSeparatedByString("Username~")
        let nonemptyUsernameInfo = usernameInfo.filter { (x) -> Bool in
            !x.isEmpty
        }
        // if there is a username/password stored
        if nonemptyUsernameInfo.count > 0
        {
            // get the username and password
            var up = nonemptyUsernameInfo[0].componentsSeparatedByString("|")
            
            // remove any leading white space
            if up [0].hasPrefix ("\n")
            {
                let newStartIndex = up [0].startIndex.advancedBy(1)
                up [0] = up [0].substringFromIndex(newStartIndex)
            }
            username = up[0]
            password = up[1]
        }
    }
    
    /// <summary>
    /// Writes cache.
    /// </summary>
    private func writeCache()
    {
        // open up the cache and read the data
        // Read data from this file.
        let path = NSBundle.mainBundle().pathForResource("cache", ofType: "txt")!
        
        var text: String = ""
        do
        {
            // read the Contact Us text file to create a database
            text = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding) as String
        }
        catch {}
        
        // split the text by the "Profile~" text
        let usernameInfo = text.componentsSeparatedByString("Username~")
        let nonemptyUsernameInfo = usernameInfo.filter { (x) -> Bool in
            !x.isEmpty
        }
        // if there is a username/password stored
        if nonemptyUsernameInfo.count > 0
        {
            // get the username and password
            var up = nonemptyUsernameInfo[0].componentsSeparatedByString("|")
            
            // remove any leading white space
            if up [0].hasPrefix ("\n")
            {
                let newStartIndex = up [0].startIndex.advancedBy(1)
                up [0] = up [0].substringFromIndex(newStartIndex)
            }
            
            // check if the username password matches
            if up[0] == usernameTextView.text
            {
                // if the password doesn't match
                if up[1] != passwordTextView.text
                {
                    // replace previous values
                    var replaced = (text as NSString).stringByReplacingOccurrencesOfString(up[0], withString: usernameTextView.text)
                    replaced = (replaced as NSString).stringByReplacingOccurrencesOfString(up[1], withString: passwordTextView.text)
                    
                    // save data back to cache
                    do {
                        let p = NSURL(fileURLWithPath: path)
                        try replaced.writeToURL(p, atomically: false, encoding: NSUTF8StringEncoding)
                        try replaced.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
                    }
                    catch {/* error handling here */}
                }
            }
            else
            {
                // replace previous values
                var replaced = (text as NSString).stringByReplacingOccurrencesOfString(up[0], withString: usernameTextView.text)
                replaced = (replaced as NSString).stringByReplacingOccurrencesOfString(up[1], withString: passwordTextView.text)
                
                // save data back to cache
                do {
                    let p = NSURL(fileURLWithPath: path)
                    try replaced.writeToURL(p, atomically: false, encoding: NSUTF8StringEncoding)
                    try replaced.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
                }
                catch {/* error handling here */}
            }
        }
        else
        {
            text = text + "\nUsername~\n" + usernameTextView.text + "|" + passwordTextView.text
            // save data back to cache
            do {
                let p = NSURL(fileURLWithPath: path)
                try text.writeToURL(p, atomically: false, encoding: NSUTF8StringEncoding)
                try text.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            }
            catch {/* error handling here */}
        }
    }
    
    /// <summary>
    /// Sets up the navigation items.
    /// </summary>
    private func setUpNavigationItems()
    {
        // set up the total height needed to take account for when setting up the view
        navigationAndStatusBarHeight =  navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height
        
        // set up the attributes of the navigation controller
        navigationController?.navigationBar.barTintColor = UniversalResources.UI_APP_COLOR_TINT
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBarHidden = true
    }
    
    /// <summary>
    /// Sets up the logo as the background.
    /// </summary>
    private func setUpNationwideOneImageView()
    {
        // set up the Image View for the background
        nationwideOneImageView = UIImageView ()
        nationwideOneImageView.backgroundColor = UIColor.clearColor()
        nationwideOneImageView.image = nationwideOneImage
        nationwideOneImageView.frame = CGRect(x: 0, y: -75, width: UIScreen.mainScreen().bounds.width, height: 3*UIScreen.mainScreen().bounds.height/4)
        
        // add the View to the Scroll View
        basisScrollView.addSubview (nationwideOneImageView)
    }
    
    /// <summary>
    /// Sets up username View.
    /// </summary>
    private func setUpUsernamePasswordView()
    {
        // set up the username Text View
        usernameTextView = UITextView ()
        var yPos = nationwideOneImageView.frame.origin.y + nationwideOneImageView.frame.height + 10
        let width = 3*UIScreen.mainScreen().bounds.width/4
        let height: CGFloat = 30
        let xPos = view.center.x - (width/2)
        usernameTextView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        usernameTextView.text = "Username"
        usernameTextView.keyboardType = UIKeyboardType.Default
        usernameTextView.returnKeyType = UIReturnKeyType.Done
        usernameTextView.textColor = UIColor.grayColor()
        usernameTextView.tintColor = UIColor.blackColor()
        usernameTextView.backgroundColor = UIColor.whiteColor()
        usernameTextView.layer.borderColor = UIColor.grayColor().CGColor
        usernameTextView.layer.cornerRadius = 5
        usernameTextView.layer.borderWidth = 1
        usernameTextView.selectable = true
        usernameTextView.delegate = self
        usernameTextView.tag = 0
        
        // set up the password Text View
        passwordTextView = UITextView ()
        yPos = usernameTextView.frame.origin.y + usernameTextView.frame.height + 5
        passwordTextView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        passwordTextView.text = "Password"
        passwordTextView.keyboardType = UIKeyboardType.Default
        passwordTextView.returnKeyType = UIReturnKeyType.Done
        passwordTextView.secureTextEntry = true
        passwordTextView.textColor = UIColor.grayColor()
        passwordTextView.tintColor = UIColor.blackColor()
        passwordTextView.backgroundColor = UIColor.whiteColor()
        passwordTextView.layer.borderColor = UIColor.grayColor().CGColor
        passwordTextView.layer.cornerRadius = 5
        passwordTextView.layer.borderWidth = 1
        passwordTextView.selectable = true
        passwordTextView.delegate = self
        passwordTextView.tag = 1
        
        
        // if data was read from the cache
        if username != "" && password != ""
        {
            // set the text
            usernameTextView.text = username
            passwordTextView.text = password
            
            // change the color
            usernameTextView.textColor = UIColor.blackColor()
            passwordTextView.textColor = UIColor.blackColor()
        }
        
        // create a Tool Bar for the done button for the Text Field keyboard
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.width, height: 44.0))
        
        // create the Tool Bar items
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        // set up the cancel Button
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SignInViewController.closeKeyboardView(_:)))
        cancelButton.tintColor = UniversalResources.UI_APP_COLOR_TINT
        cancelButton.tag = 0
        
        // set up the done Button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SignInViewController.closeKeyboardView(_:)))
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
        usernameTextView.inputAccessoryView = toolbar
        passwordTextView.inputAccessoryView = toolbar
        
        // add the Views to the Scroll View
        basisScrollView.addSubview (usernameTextView)
        basisScrollView.addSubview (passwordTextView)
    }
    
    /// <summary>
    /// Sets up the navigation items.
    /// </summary>
    private func setUpRememberMe()
    {
        // set up the remember me Label
        rememberMeLabel = UILabel()
        rememberMeLabel.text = "Remember Me"
        rememberMeLabel.textColor = UIColor.blackColor()
        rememberMeLabel.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 10)
        let size: CGSize = rememberMeLabel.text!.sizeWithAttributes ([NSFontAttributeName: rememberMeLabel.font])
        var yPos = passwordTextView.frame.origin.y + passwordTextView.frame.height + 5
        yPos += 7.5
        rememberMeLabel.frame = CGRect(origin: CGPoint(x: passwordTextView.frame.origin.x, y: yPos), size: size)
        
        // set up the remember me Button
        rememberMeButton = UIButton ()
        rememberMeButton.setImage(UniversalResources.UNCHECKED_CHECK_BOX_IMAGE, forState: UIControlState.Normal)
        rememberMeButton.backgroundColor = UIColor.clearColor()
        yPos = passwordTextView.frame.origin.y + passwordTextView.frame.height + 5
        let xPos = rememberMeLabel.frame.origin.x + rememberMeLabel.frame.width + 2
        rememberMeButton.frame = CGRect(x: xPos, y: yPos, width: 30, height: 30)
        rememberMeButton.addTarget(self, action: #selector(SignInViewController.buttonStateChanged(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        // add subViews to View
        basisScrollView.addSubview(rememberMeButton)
        basisScrollView.addSubview(rememberMeLabel)
    }
    
    /// <summary>
    /// Sets up Sign In Button.
    /// </summary>
    private func setUpSignInButton()
    {
        // the y position for the Button
        let yPos = rememberMeButton.frame.origin.y + rememberMeButton.frame.height + 5
        
        // the width for the checkout Button
        let width = 3*UIScreen.mainScreen().bounds.width/4
        
        // the x position for the Button
        let xPos = view.center.x - (width/2)
        
        // create the Login Button and set up all the accessories
        signInButton = UIButton(type: UIButtonType.Custom)
        signInButton.titleLabel?.font = UIFont (name: UniversalResources.FONT_NAME_BOLD, size: 11)
        signInButton.frame = CGRect(x: xPos, y: yPos, width: width, height: 35)
        signInButton.setTitle("Sign In", forState: UIControlState.Normal)
        signInButton.setTitle("Sign In", forState: UIControlState.Disabled)
        signInButton.backgroundColor = UniversalResources.UI_APP_COLOR_TINT
        signInButton.layer.cornerRadius = 2
        signInButton.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        signInButton.addTarget(self, action: #selector(SignInViewController.signIn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // add save Button to View
        basisScrollView.addSubview(signInButton)
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
            if textViewCaller == usernameCaller
            {
                // set the previous text value
                usernameTextView.text = username
                
                // release the focus
                usernameTextView.resignFirstResponder()
            }
            // if the password Text View is the current caller
            else if textViewCaller == passwordCaller
            {
                // set the previous text value
                passwordTextView.text = password
                
                // release the focus
                passwordTextView.resignFirstResponder()
            }
        }
    }
    
    /// <summary>
    /// Authenticates the user by touch ID
    /// </summary>
    private func authenticateUser()
    {
        // Get the local authentication context.
        let context : LAContext = LAContext()
        
        // Declare a NSError variable.
        var error: NSError?
        
        // Set the reason string that will appear on the authentication alert.
        var reasonString = "Authentication is needed to access your notes."
        
        // Check if the device can evaluate the policy.
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
                
                if success {
                    
                }
                else{
                    // If authentication failed then show a message to the console with a short description.
                    // In case that the error is a user fallback, then show the password alert view.
                    print(evalPolicyError?.localizedDescription)
                    
                    switch evalPolicyError!.code {
                        
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        
                    case LAError.UserFallback.rawValue:
                        print("User selected to enter custom password")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            
                        })
                        
                    default:
                        print("Authentication failed")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            
                        })
                    }
                }
            })]
        }
        else{
            // If the security policy cannot be evaluated then show a short message depending on the error.
            switch error!.code{
                
            case LAError.TouchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled")
                
            case LAError.PasscodeNotSet.rawValue:
                print("A passcode has not been set")
                
            default:
                // The LAError.TouchIDNotAvailable case.
                print("TouchID not available")
            }
            
            // Optionally the error description can be displayed on the console.
            print(error?.localizedDescription)
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
            let height = view.frame.height - UniversalResources.SCROLL_AMOUNT - 44
            
            // set the frame
            basisScrollView.frame = CGRect(x: 0, y: 0, width: basisScrollView.frame.width, height: height)
            
            // if the Text View needed to scroll for is the username Text View
            if whichTextView == usernameCaller
            {
                // get the bottom position from the username Text View
                let bottom = usernameTextView.frame.origin.y + usernameTextView.frame.height - height
                
                // if the bottom position is greater than zero, the content offset needs to be adjusted
                if(bottom > 0)
                {
                    basisScrollView.setContentOffset (CGPoint (x: 0, y: bottom), animated: true)
                    scrollViewOffsetPosition = CGPoint (x: 0, y: bottom)
                }
            }
            // if the Text View needed to scroll for is the password Text View
            else if whichTextView == passwordCaller
            {
                // get the bottom position from the username Text View
                let bottom = passwordTextView.frame.origin.y + passwordTextView.frame.height - height
                
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