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
    
    // the String representing the UserProfile short name
    var shortName: String
        {
        get { return theShortName}
        set (newShortName) { self.theShortName = newShortName }
    }
    
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
    
    // the String representing the UserProfile specialties
    var specialties: String
        {
        get { return theSpecialties }
        set (newSpecialties) { self.theSpecialties = newSpecialties }
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
    
    // the String representing the UserProfile hobbies
    var hobbies: String
        {
        get { return theHobbies }
        set (newHobbies) { self.theHobbies = newHobbies }
    }
    
    // the String representing the UserProfile title
    var title: String
        {
        get { return theTitle }
        set (newTitle) { self.theTitle = newTitle }
    }
    
    // the String representing the UserProfile role
    var role: String
        {
        get { return theRole }
        set (newRole) { self.theRole = newRole }
    }
    
    // the String representing the UserProfile location
    var location: String
        {
        get { return theLocation }
        set (newLocation) { self.theLocation = newLocation }
    }
    
    
    // the Hash Value
    var hashValue: Int
        {
        get { return (13 * name.characters.count + 27) * Int(arc4random_uniform(100) + 1) + hobbies.hashValue }
    }
    
    
    
    
    // MARK: - all fields that relate to the internal class
    
    // the String representing the UserProfile short name
    private var theShortName: String = ""
    
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
    
    // the String representing the UserProfile about me
    private var theAboutMe: String = ""
    
    // the String representing the UserProfile picture
    private var thePicture: String = ""
    
    // the String representing the UserProfile department
    private var theSpecialties: String = ""
    
    // the String representing the UserProfile department
    private var theSchools: String = ""
    
    // the String representing the UserProfile department
    private var theBirthday: String = ""
    
    // the String representing the UserProfile department
    private var theHobbies: String = ""
    
    // the String representing the UserProfile department
    private var theTitle: String = ""
    
    // the String representing the UserProfile department
    private var theRole: String = ""
    
    // the String representing the UserProfile department
    private var theLocation: String = ""
    
    
    
    // MARK: - all functions that relate to the static public accessing
    
    /// <summary>
    /// Searches for a UserProfile by name.
    /// </summary>
    static func findUserProfileByName(name: String) -> UserProfile
    {
        // loop through all profiles
        for user in UniversalResources.PROFILES
        {
            // if the name matches
            if user.name == name
            {
                return user
            }
        }
        
        // return an empty UserProfile
        return UserProfile()
    }
    
    /// <summary>
    /// Searches for a UserProfile by short name.
    /// </summary>
    static func findUserProfileByShortName(shortName: String) -> UserProfile
    {
        // loop through all profiles
        for user in UniversalResources.PROFILES
        {
            // if the short name matches
            if user.shortName == shortName
            {
                return user
            }
        }
        
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
        shortName = ""
        name = ""
        workPhone = ""
        mobilePhone = ""
        workEmail = ""
        department = ""
        aboutMe = ""
        picture = ""
        specialties = ""
        schools = ""
        birthday = ""
        hobbies = ""
        title = ""
        role = ""
        location = ""
    }
    
    /// <summary>
    /// Initializes a new instance of the UserProfile class.
    /// </summary>
    /// <param name="name">UserProfile short name.</param>
    /// <param name="name">UserProfile name.</param>
    /// <param name="workPhone">UserProfile work phone number.</param>
    /// <param name="mobilePhone">UserProfile mobile phone number.</param>
    /// <param name="workEmail">UserProfile work email.</param>
    /// <param name="department">UserProfile department.</param>
    /// <param name="manager">UserProfile manager.</param>
    /// <param name="aboutMe">UserProfile about me.</param>
    /// <param name="picture">UserProfile picture.</param>
    /// <param name="specialties">UserProfile specialties.</param>
    /// <param name="schools">UserProfile schools.</param>
    /// <param name="birthday">UserProfile birthday.</param>
    /// <param name="hobbies">UserProfile hobbies.</param>
    init (shortName: String, name: String, workPhone: String, mobilePhone: String, workEmail: String, department: String, manager: UserProfile, aboutMe: String, picture: String, specialties: String, schools: String, birthday: String, hobbies: String, title: String, role: String, location: String)
    {
        // set the values
        self.shortName = shortName
        self.name = name
        self.workPhone = workPhone
        self.mobilePhone = mobilePhone
        self.workEmail = workEmail
        self.department = department
        self.manager = UserProfile(userProfileToCopy: manager)
        self.aboutMe = aboutMe
        self.picture = picture
        self.specialties = specialties
        self.schools = schools
        self.birthday = birthday
        self.hobbies = hobbies
        self.title = title
        self.role = role
        self.location = location
    }
    
    /// <summary>
    /// Initializes a new instance of the UserProfile class.
    /// </summary>
    /// <param name="userProfileToCopy">UserProfile to copy.</param>
    init (userProfileToCopy: UserProfile)
    {
        // set the values
        self.shortName = userProfileToCopy.shortName
        self.name = userProfileToCopy.name
        self.workPhone = userProfileToCopy.workPhone
        self.mobilePhone = userProfileToCopy.mobilePhone
        self.workEmail = userProfileToCopy.workEmail
        self.department = userProfileToCopy.department
        self.manager = userProfileToCopy.manager
        self.aboutMe = userProfileToCopy.aboutMe
        self.picture = userProfileToCopy.picture
        self.specialties = userProfileToCopy.specialties
        self.schools = userProfileToCopy.schools
        self.birthday = userProfileToCopy.birthday
        self.hobbies = userProfileToCopy.hobbies
        self.title = userProfileToCopy.title
        self.role = userProfileToCopy.role
        self.location = userProfileToCopy.location
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
        if self.shortName != userProfileToCompare.shortName
            || self.name != userProfileToCompare.name
            || self.workPhone != userProfileToCompare.workPhone
            || self.mobilePhone != userProfileToCompare.mobilePhone
            || self.workEmail != userProfileToCompare.workEmail
            || self.department != userProfileToCompare.department
            || self.manager != userProfileToCompare.manager
            || self.aboutMe != userProfileToCompare.aboutMe
            || self.picture != userProfileToCompare.picture
            || self.specialties != userProfileToCompare.specialties
            || self.schools != userProfileToCompare.schools
            || self.birthday != userProfileToCompare.birthday
            || self.hobbies != userProfileToCompare.hobbies
            || self.title != userProfileToCompare.title
            || self.role != userProfileToCompare.role
            || self.location != userProfileToCompare.location
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
    if lhs.shortName != rhs.shortName
        || lhs.name != rhs.name
        || lhs.workPhone != rhs.workPhone
        || lhs.mobilePhone != rhs.mobilePhone
        || lhs.workEmail != rhs.workEmail
        || lhs.department != rhs.department
        || lhs.manager != rhs.manager
        || lhs.aboutMe != rhs.aboutMe
        || lhs.picture != rhs.picture
        || lhs.specialties != rhs.specialties
        || lhs.schools != rhs.schools
        || lhs.birthday != rhs.birthday
        || lhs.hobbies != rhs.hobbies
        || lhs.title != rhs.title
        || lhs.role != rhs.role
        || lhs.location != rhs.location
    {
        // conditions are not met, return not equal
        return false
    }
    
    // conditions are met, return equal
    return true
}
