//
//  UniversalResources.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit
class UniversalResources
{
    // MARK: - all field that relate to the static public accessing
    
    
    // MARK: - all fields that relate to the universal UI View
    
    // the official storyboard
    static let STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
    
    // the current/top View Controller that is presented to the screen
    static var TOP_VC = ""
    
    
    // MARK: - all fields that relate to the universal application colors
    
    // the constants that represent the applications colors
    static let UI_APP_COLOR_TINT = UIColor(red: (30/255), green: (87/255), blue: (166/255), alpha: 1.0)
    static let CG_APP_COLOR_TINT = UI_APP_COLOR_TINT.CGColor
    
    
    // MARK: - all fields that relate to the universal fonts
    
    // the font type used for the app
    static let FONT_NAME_REGULAR = ".SFUIText-Regular"
    static let FONT_NAME_BOLD = ".SFUIText-Bold"
    static let FONT_NAME_ITALIC = ".SFUIText-Italic"
    
    
    // MARK: - all fields that relate to the universal images
    
    // the images used for the app
    static let ARROW_IMAGE = UIImage (named: "ic-arrow@2x.png")!
    static let BUG_IMAGE = UIImage (named: "ic-bug@2x.png")!
    static let CAFE_IMAGE = UIImage (named: "ic-cafe@2x.png")!
    static let CHECKED_CHECK_BOX_IMAGE = UIImage (named: "ic-checked-check-box@2x.png")!
    static let UNCHECKED_CHECK_BOX_IMAGE = UIImage (named: "ic-unchecked-check-box@2x.png")!
    static let CIRCLE_CHECK_APP_COLOR_IMAGE = UIImage (named: "ic-circle-check-app-color@2x.png")!
    static let CIRCLE_CHECK_BLACK_IMAGE = UIImage (named: "ic-circle-check-black@2x.png")!
    static let CIRCLE_FILLED_APP_COLOR_IMAGE = UIImage (named: "ic-circle-filled-app-color@2x.png")!
    static let CIRCLE_FILLED_BLACK_IMAGE = UIImage (named: "ic-circle-filled-black@2x.png")!
    static let CIRCLE_OUTLINE_APP_COLOR_IMAGE = UIImage (named: "ic-circle-outline-app-color@2x.png")!
    static let CIRCLE_OUTLINE_BLACK_IMAGE = UIImage (named: "ic-circle-outline-black@2x.png")!
    static let CLOSE_IMAGE = UIImage (named: "ic-close@2x.png")!
    static let CONTACT_IMAGE = UIImage (named: "ic-contact@2x.png")!
    static let E_BIZ_IMAGE = UIImage (named: "ic-e-biz@2x.png")!
    static let FEEDBACK_IMAGE = UIImage (named: "ic-feedback@2x.png")!
    static let HEART_EMPTY_BLACK_IMAGE = UIImage (named: "ic-heart-empty-black@2x.png")!
    static let HEART_EMPTY_RED_IMAGE = UIImage (named: "ic-heart-empty-red@2x.png")!
    static let HEART_FILLED_BLACK_IMAGE = UIImage (named: "ic-heart-filled-black@2x.png")!
    static let HEART_FILLED_RED_IMAGE = UIImage (named: "ic-heart-filled-red@2x.png")!
    static let HISTORY_IMAGE = UIImage (named: "ic-history@2x.png")!
    static let HOME_IMAGE = UIImage (named: "ic-home@2x.png")!
    static let HOME_BLACK_IMAGE = UIImage (named: "ic-home-black@2x.png")!
    static let HOME_WHITE_IMAGE = UIImage (named: "ic-home-white@2x.png")!
    static let MENU_IMAGE = UIImage (named: "ic-menu@2x.png")!
    static let PHONE_OUTLINE_BLACK_IMAGE = UIImage (named: "ic-phone-outline-black@2x.png")!
    static let PHONE_WHITE_IMAGE = UIImage (named: "ic-phone-white@2x.png")!
    static let REPLAY_IMAGE = UIImage (named: "ic-replay@2x.png")!
    static let RSS_FEED_IMAGE = UIImage (named: "ic-rss-feed@2x.png")!
    static let SETTINGS_IMAGE = UIImage (named: "ic-settings@2x.png")!
    static let SIGNIN_IMAGE = UIImage (named: "ic-login@2x.png")!
    static let SIGNOUT_IMAGE = UIImage (named: "ic-sign-out@2x.png")!
    static let SUGGESTION_IMAGE = UIImage (named: "ic-suggestion@2x.png")!
    static let NATIONWIDE_ONE_RETINA_IMAGE = UIImage (named: "nationwide-one-loading.png")!
    static let NATIONWIDE_ONE_BLUE_BACKGROUND_IMAGE = UIImage (named: "nationwide-one-blue-background.jpg")!
    static let FACEBOOK_IMAGE = UIImage (named: "facebook_icon.png")!
    static let INSTAGRAM_IMAGE = UIImage (named: "instagram_icon.png")!
    static let PINTEREST_IMAGE = UIImage (named: "pinterest_icon.png")!
    static let TWITTER_IMAGE = UIImage (named: "twitter_icon.png")!
    static let EMAIL_IMAGE = UIImage (named: "ic-message@2x.png")!
    static let CALENDAR_IMAGE = UIImage (named: "ic-calendar@2x.png")!
    static let SPOT_NOTE_IMAGE = UIImage (named: "ic-spot-note@2x.png")!
    static let ANYTHING_LOCATOR_IMAGE = UIImage (named: "ic-location@2x.png")!
    static let PROFILE_IMAGE = UIImage (named: "ic-profile-pic@2x.png")!
    static let LOGO_TRANSPARENT_IMAGE = UIImage (named: "ic-logo-transparent@2x.png")!
    static let LOGO_BLUE_IMAGE = UIImage (named: "ic-logo-blue.jpg")
    static let LOGO_WHITE_IMAGE = UIImage (named: "ic-logo-white.png")
    static let LOGO_TOP_BAR_IMAGE = UIImage (named: "ic-logo-topbar.png")
    
    
    
    
    // MARK: - all fields that relate to the keyboard settings when the keyboard shows/hides
    
    // the CGFloat that tells how much the view should scroll by
    static var SCROLL_AMOUNT = CGFloat(253)
    
    // the Double that tells how long the view should animate by
    static let SCROLL_ANIMATION_DURATION = 0.25
    
    // the Enum that tells the Animation Curve
    static let SCROLL_ANIMATION_CURVE = UIViewAnimationCurve.EaseInOut
    
    // the String that will contain which View Controller the keyboard was called from
    static var KEYBOARD_VIEW_CONTROLLER_LOCATION = ""
    
    
    
    // MARK: - all fields that relate to the universal animations
    
    // the Double that tells how long the view should animate by
    static let UNIVERSAL_ANIMATION_DURATION = 0.3
    
    
    
    
    // MARK: - all fields that relate to the Side Menu
    
    // the Array of Food's that exist in the menu when the user is logged in
    static var SIDE_MENU_ITEMS: [String] = []
    
    // the Dictionary containing the Food item and the description when the user is logged in
    static var SIDE_MENU_DESCRIPTION_ITEMS = Dictionary<String, String>()
    
    
    
    // the Array of String that holds the different issues
    static var CONTACT_US_ITEMS: [String] = []
    
    // the Dictionary containing the issue type and description of that issue type
    static var CONTACT_US_DESCRIPTION_ITEMS = Dictionary<String, String>()
    
    // the Array of String that holds the different issues type for the charges
    static var CONTACT_US_CHARGES_ISSUES: [String] = []
    
    // the Dictionary containing the charges issue type and description of that charges issue type
    static var CONTACT_US_CHARGES_DESCRIPTION = Dictionary<String, String>()
    
    
    // MARK: - all fields that relate to the Profiles
    
    // the Array of Strings that holds the User Profiles
    static var PROFILES: [UserProfile] = []
    
    // the user that is currently signed in
    static var SIGNED_IN_PROFILE: UserProfile!
    
    
    
    // MARK: - all functions that relate to the static public accessing
    
    /// <summary>
    /// Sets up the Profile database.
    /// </summary>
    static func setUpProfileDatabase()
    {
        // reset any data incase it was somehow locally stored
        PROFILES.removeAll()
        
        // Read data from this file.
        let path = NSBundle.mainBundle().pathForResource("Profiles", ofType: "txt")!
        
        var text: String = ""
        do
        {
            // read the Contact Us text file to create a database
            text = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding) as String
        }
        catch {}
        
        // split the text by the "Profile~" text
        let allProfiles = text.componentsSeparatedByString("Profile~")
        let nonemptyProfiles = allProfiles.filter { (x) -> Bool in
            !x.isEmpty
        }
        
        // loop through all the Profiles
        for profile in nonemptyProfiles
        {
            // split the string up by type and value
            let typesAndValuesString = profile.componentsSeparatedByString("\n")
            
            // create a new UserProfile
            let newProfile: UserProfile = UserProfile()
            
            // loop through the types and values
            for typeAndValueString in typesAndValuesString
            {
                // get the two componenets in the type and value and separate them
                let typeValue = typeAndValueString.componentsSeparatedByString("|")
                
                // if this type is the short name
                if typeValue[0] == "Short Name"
                {
                    // set the short name
                    newProfile.shortName = typeValue[1]
                }
                // if this type is the name
                else if typeValue[0] == "Name"
                {
                    // set the name
                    newProfile.name = typeValue[1]
                }
                    // if this type is the work phone
                else if typeValue[0] == "Work Phone"
                {
                    // set the work phone number
                    newProfile.workPhone = typeValue[1]
                }
                    // if this type is the mobile phone
                else if typeValue[0] == "Mobile Phone"
                {
                    // set the mobile phone number
                    newProfile.mobilePhone = typeValue[1]
                }
                    // if this type is the work email
                else if typeValue[0] == "Work Email"
                {
                    // set the work email
                    newProfile.workEmail = typeValue[1]
                }
                    // if this type is the department
                else if typeValue[0] == "Department"
                {
                    // set the department
                    newProfile.department = typeValue[1]
                }
                    // if this type is the manager
                else if typeValue[0] == "Manager"
                {
                    // set the manager
                    newProfile.manager = typeValue[1]
                }
                    // if this type is the picture
                else if typeValue[0] == "Picture"
                {
                    // set the picture
                    newProfile.picture = typeValue[1]
                }
                    // if this type is the expertise
                else if typeValue[0] == "About Me"
                {
                    // set the expertise
                    newProfile.aboutMe = typeValue[1]
                }
                    // if this type is the expertise
                else if typeValue[0] == "Specialties"
                {
                    // set the expertise
                    newProfile.specialties = typeValue[1]
                }
                    // if this type is the schools
                else if typeValue[0] == "Schools"
                {
                    // set the schools
                    newProfile.schools = typeValue[1]
                }
                    // if this type is the birthday
                else if typeValue[0] == "Birthday"
                {
                    // set the birthday
                    newProfile.birthday = typeValue[1]
                }
                    // if this type is the interests
                else if typeValue[0] == "Hobbies"
                {
                    // set the interests
                    newProfile.hobbies = typeValue[1]
                }
                    // if this type is the title
                else if typeValue[0] == "Title"
                {
                    // set the title
                    newProfile.title = typeValue[1]
                }
                    // if this type is the role
                else if typeValue[0] == "Role"
                {
                    // set the role
                    newProfile.role = typeValue[1]
                }
                    // if this type is the location
                else if typeValue[0] == "Location"
                {
                    // set the location
                    newProfile.location = typeValue[1]
                }
            }
            
            // insert the new UserProfile in the database
            PROFILES.insert(newProfile, atIndex: PROFILES.count)
        }
    }
    
    
    /// <summary>
    /// Sets up the menu database.
    /// </summary>
    static func setUpSideMenuDatabase()
    {
        // Read data from this file.
        let path = NSBundle.mainBundle().pathForResource("MenuItems", ofType: "txt")!
        
        var text: String = ""
        do
        {
            // read the Contact Us text file to create a database
            text = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding) as String
        }
        catch {}
        
        // split the text by the new line character
        let menuOptions = text.componentsSeparatedByString("\n")
        
        
        // initialize the menu table items and descriptions
        SIDE_MENU_ITEMS = []
        SIDE_MENU_DESCRIPTION_ITEMS = Dictionary<String, String> ()
        
        // loop through the different types of menus (whether the user is logged in or not
        for menuOption in menuOptions
        {
            // split the string up by the menu items in the logged in or logged out list
            var menuItems = menuOption.componentsSeparatedByString("|")
            
            // remove any leading white space
            if menuItems [0].hasPrefix ("\n")
            {
                let newStartIndex = menuItems [0].startIndex.advancedBy(1)
                menuItems [0] = menuItems [0].substringFromIndex(newStartIndex)
            }
            
            // menuItems[0] is the item, while menuItems[1] is the description
            
            // if the word "Sign Out" exists within the string
            if menuItems [0].containsString("Sign Out")
            {
                // add a sad face emoticon
                menuItems [1] = menuItems [1] + " 😔"
            }
            
            // add the menu table item and it's description to the table database
            SIDE_MENU_ITEMS.insert(menuItems[0], atIndex: SIDE_MENU_ITEMS.count)
            SIDE_MENU_DESCRIPTION_ITEMS.updateValue (menuItems [1], forKey: menuItems[0])
        }
    }
    
    /*
    /// <summary>
    /// Sets up Contact Us database.
    /// </summary>
    static func setUpContactUsDatabase()
    {
        // Read data from this file.
        let path = NSBundle.mainBundle().pathForResource("ContactUs", ofType: "txt")!
        
        var text: String = ""
        do
        {
            // read the Contact Us text file to create a database
            text = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding) as String
        }
        catch {}
        
        // split the text by the new line character
        let items = text.componentsSeparatedByString("\n")
        
        // go through all promo codes and add them to a database
        for item in items
        {
            // if this is a Customer Care item
            if item.containsString("Customer Care")
            {
                // add to database
                CONTACT_US_ITEMS.insert(item, atIndex: CONTACT_US_ITEMS.count)
            }
            else
            {
                // get the title and description and add to the database
                // titleAndDescription[0] is the title and titleAndDescription[1] is the description
                let titleAndDescription = item.componentsSeparatedByString(";")
                CONTACT_US_ITEMS.insert(titleAndDescription[0], at: CONTACT_US_ITEMS.count)
                CONTACT_US_DESCRIPTION_ITEMS.updateValue(titleAndDescription[1], forKey: titleAndDescription[0])
            }
        }
    }
    
    /// <summary>
    /// Sets up feedback database.
    /// </summary>
    static func setUpContactUsChargesIssuesDatabase()
    {
        // Read data from this file.
        let path = NSBundle.mainBundle().pathForResource("ContactUsIssue", ofType: "txt")!
        
        var text: String = ""
        do
        {
            // read the Contact Us text file to create a database
            text = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding) as String
        }
        catch {}
        
        // split the text by the new line character
        let issues = text.componentsSeparatedByString("~")
        
        // go through all issues and add them to a database
        for issue in issues
        {
            // get the title and description and add to the database
            // titleAndDescription[0] is the title and titleAndDescription[1] is the description
            let titleAndDescription = issue.componentsSeparatedByString(";")
            CONTACT_US_CHARGES_ISSUES.insert(titleAndDescription[0], atIndex: CONTACT_US_CHARGES_ISSUES.count)
            CONTACT_US_CHARGES_DESCRIPTION.updateValue(titleAndDescription[1], forKey: titleAndDescription[0])
        }
    }
 */
}
