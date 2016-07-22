//
//  UserProfile.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class UserProfile: Hashable
{
    // MARK: - all field that relate to the static public accessing
    
    
    
    // MARK: - all fields that relate public accessing
    
    // the String representing the UserProfile name
    var name: String
        {
        get { return theName}
        set (newName) { self.theName = newName }
    }
    
    // the String representing the UserProfile work phone number
    var workPhone: String
        {
        get { return theWorkPhone }
        set (newWorkPhone) { self.theWorkPhone = newWorkPhone }
    }
    
    // the String representing the UserProfile mobile phone number
    var mobilePhone: String
        {
        get { return theMobilePhone }
        set (newMobilePhone) { self.theMobilePhone = newMobilePhone }
    }
    
    // the String representing the UserProfile work email
    var workEmail: String
        {
        get { return theWorkEmail }
        set (newWorkEmail) { self.theWorkEmail = newWorkEmail }
    }
    
    // the String representing the UserProfile department
    var department: String
        {
        get { return theDepartment }
        set (newDepartment) { self.theDepartment = newDepartment }
    }
    
    // the String representing the UserProfile manager
    var manager: UserProfile
        {
        get { return theManager }
        set (newManager) { self.theManager = UserProfile(userProfileToCopy: newManager) }
    }
    
    // the String representing the UserProfile about me
    var aboutMe: String
        {
        get { return theAboutMe }
        set (newAboutMe) { self.theAboutMe = newAboutMe }
    }
    
    // the String representing the UserProfile picture
    var picture: String
        {
        get { return thePicture }
        set (newPicture) { self.thePicture = newPicture }
    }
    
    // the String representing the UserProfile expertise
    var expertise: String
        {
        get { return theExpertise }
        set (newExpertise) { self.theExpertise = newExpertise }
    }
    
    // the String representing the UserProfile schools
    var schools: String
        {
        get { return theSchools }
        set (newSchools) { self.theSchools = newSchools }
    }
    
    // the String representing the UserProfile birthday
    var birthday: String
        {
        get { return theBirthday }
        set (newBirthday) { self.theBirthday = newBirthday }
    }
    
    // the String representing the UserProfile interests
    var interests: String
        {
        get { return theInterests }
        set (newInterests) { self.theInterests = newInterests }
    }
    
    
    // the Hash Value
    var hashValue: Int
        {
        get { return (13 * name.characters.count + 27) * Int(arc4random_uniform(100) + 1) + interests.hashValue }
    }
    
    
    
    
    // MARK: - all fields that relate to the internal class
    
    // the String representing the UserProfile name
    private var theName: String = ""
    
    // the String representing the UserProfile work phone number
    private var theWorkPhone: String = ""
    
    // the String representing the UserProfile mobile phone number
    private var theMobilePhone: String = ""
    
    // the String representing the UserProfile work email
    private var theWorkEmail: String = ""
    
    // the String representing the UserProfile department
    private var theDepartment: String = ""
    
    // the UserProfile representing the UserProfile manager
    private var theManager: UserProfile!
    
    // the String representing the UserProfile department
    private var theAboutMe: String = ""
    
    // the String representing the UserProfile department
    private var thePicture: String = ""
    
    // the String representing the UserProfile department
    private var theExpertise: String = ""
    
    // the String representing the UserProfile department
    private var theSchools: String = ""
    
    // the String representing the UserProfile department
    private var theBirthday: String = ""
    
    // the String representing the UserProfile department
    private var theInterests: String = ""
    
    
    
    
    // MARK: - all functions that relate to the static public accessing
    
    /// <summary>
    /// Searches for a UserProfile by name.
    /// </summary>
    static func findUserProfileByName(name: String) -> UserProfile
    {
        //TODO find user by name
        
        // return an empty UserProfile
        return UserProfile()
    }
    
    
    // MARK: - all functions that relate to the internal class for public accessing
    
    /// <summary>
    /// Initializes a new instance of the UserProfile class.
    /// </summary>
    init()
    {
        // set the default
        name = ""
        workPhone = ""
        mobilePhone = ""
        workEmail = ""
        department = ""
        aboutMe = ""
        picture = ""
        expertise = ""
        schools = ""
        birthday = ""
        interests = ""
    }
    
    /// <summary>
    /// Initializes a new instance of the UserProfile class.
    /// </summary>
    /// <param name="name">UserProfile type.</param>
    /// <param name="workPhone">UserProfile work phone number.</param>
    /// <param name="mobilePhone">UserProfile mobile phone number.</param>
    /// <param name="workEmail">UserProfile work email.</param>
    /// <param name="department">UserProfile department.</param>
    /// <param name="manager">UserProfile manager.</param>
    /// <param name="aboutMe">UserProfile about me.</param>
    /// <param name="picture">UserProfile picture.</param>
    /// <param name="expertise">UserProfile expertise.</param>
    /// <param name="schools">UserProfile schools.</param>
    /// <param name="birthday">UserProfile birthday.</param>
    /// <param name="interests">UserProfile interests.</param>
    init (name: String, workPhone: String, mobilePhone: String, workEmail: String, department: String, manager: UserProfile, aboutMe: String, picture: String, expertise: String, schools: String, birthday: String, interests: String)
    {
        // set the values
        self.name = name
        self.workPhone = workPhone
        self.mobilePhone = mobilePhone
        self.workEmail = workEmail
        self.department = department
        self.manager = UserProfile(userProfileToCopy: manager)
        self.aboutMe = aboutMe
        self.picture = picture
        self.expertise = expertise
        self.schools = schools
        self.birthday = birthday
        self.interests = interests
    }
    
    /// <summary>
    /// Initializes a new instance of the UserProfile class.
    /// </summary>
    /// <param name="userProfileToCopy">UserProfile to copy.</param>
    init (userProfileToCopy: UserProfile)
    {
        // set the values
        self.name = userProfileToCopy.name
        self.workPhone = userProfileToCopy.workPhone
        self.mobilePhone = userProfileToCopy.mobilePhone
        self.workEmail = userProfileToCopy.workEmail
        self.department = userProfileToCopy.department
        self.manager = userProfileToCopy.manager
        self.aboutMe = userProfileToCopy.aboutMe
        self.picture = userProfileToCopy.picture
        self.expertise = userProfileToCopy.expertise
        self.schools = userProfileToCopy.schools
        self.birthday = userProfileToCopy.birthday
        self.interests = userProfileToCopy.interests
    }
    
    
    /// <summary>
    /// Determines whether the specified UserProfile is equal to the current UserProfile.
    /// </summary>
    /// <param name="userProfileToCompare">The UserProfile to compare with the current UserProfile.</param>
    /// <returns><c>true</c> if the specified UserProfile is equal to the current UserProfile
    /// otherwise, <c>false</c>.</returns>
    func equals(userProfileToCompare: UserProfile) -> Bool
    {
        // if none of the conditions are met, it's not equal
        if self.name != userProfileToCompare.name
            || self.workPhone != userProfileToCompare.workPhone
            || self.mobilePhone != userProfileToCompare.mobilePhone
            || self.workEmail != userProfileToCompare.workEmail
            || self.department != userProfileToCompare.department
            || self.manager != userProfileToCompare.manager
            || self.aboutMe != userProfileToCompare.aboutMe
            || self.picture != userProfileToCompare.picture
            || self.expertise != userProfileToCompare.expertise
            || self.schools != userProfileToCompare.schools
            || self.birthday != userProfileToCompare.birthday
            || self.interests != userProfileToCompare.interests
        {
            // conditions are not met, return not equal
            return false
        }
        
        // conditions are met, return equal
        return true
    }
}


// MARK: - all functions that relate to the super class

/// <summary>
/// Determines if two Credit Card's are equal.
/// </summary>
/// <param name="lhs">The UserProfile to compare UserProfile.</param>
/// <param name="rhs">The UserProfile to compare UserProfile.</param>
/// <returns><c>true</c> if the specified UserProfile is equal to the another UserProfile
/// otherwise, <c>false</c>.</returns>
func == (lhs: UserProfile, rhs: UserProfile) -> Bool
{
    // if none of the conditions are met, it's not equal
    if lhs.name != rhs.name
        || lhs.workPhone != rhs.workPhone
        || lhs.mobilePhone != rhs.mobilePhone
        || lhs.workEmail != rhs.workEmail
        || lhs.department != rhs.department
        || lhs.manager != rhs.manager
        || lhs.aboutMe != rhs.aboutMe
        || lhs.picture != rhs.picture
        || lhs.expertise != rhs.expertise
        || lhs.schools != rhs.schools
        || lhs.birthday != rhs.birthday
        || lhs.interests != rhs.interests
    {
        // conditions are not met, return not equal
        return false
    }
    
    // conditions are met, return equal
    return true
}
