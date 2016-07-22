//
//  SMESearchTableViewCell.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/22/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class SMESearchTableViewCell: UITableViewCell
{
    // MARK: - all fields that relate to the internal class for public accessing
    
    // the Label to describe the name of the SME Search
    var nameLabel: UILabel!
    
    // the Label to describe the description of the SME Search
    var searchDescriptionLabel: UILabel!
    
    // the Image View to describe the image of the SME Search
    var userProfileImageImageView: UIImageView!
    
    
    
    
    // MARK: - all overrided functions that relate to the Table View Cell super class
    
    /// <summary>
    /// Initializer
    /// </summary>
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    /// <summary>
    /// Initializer
    /// </summary>
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // set the selction style and background color
        selectionStyle = UITableViewCellSelectionStyle.None
        contentView.backgroundColor = UIColor.whiteColor()
        
        // set up the two Labels needed to describe the menu options
        nameLabel = UILabel ()
        nameLabel.font = UIFont (name: UniversalResources.FONT_NAME_BOLD, size: 14)
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.backgroundColor = UIColor.clearColor()
        
        searchDescriptionLabel = UILabel ()
        searchDescriptionLabel.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 12)
        searchDescriptionLabel.textColor = UIColor.blackColor()
        searchDescriptionLabel.backgroundColor = UIColor.clearColor()
        
        // set up the Image View of the menu item
        userProfileImageImageView = UIImageView ()
        userProfileImageImageView.backgroundColor = UIColor.clearColor()
        
        // add the subviews
        contentView.addSubview(nameLabel)
        contentView.addSubview(searchDescriptionLabel)
        contentView.addSubview(userProfileImageImageView)
    }
    
    
    /// <summary>
    /// Layouts the subviews.
    /// </summary>
    override func layoutSubviews()
    {
        super.layoutSubviews ()
        
        // position the frame for the menu image
        userProfileImageImageView.frame = CGRectMake(10, contentView.bounds.height/2 - 10, 20, 20)
        
        // the x position for the title and description
        let xPos = userProfileImageImageView.frame.origin.x + userProfileImageImageView.frame.width + 10
        
        // position the frame for the name
        var size: CGSize = nameLabel.text!.sizeWithAttributes ([NSFontAttributeName:  nameLabel.font])
        nameLabel.frame = CGRect (origin: CGPoint (x: xPos, y: 5), size: size)
        
        // position the frame for the description
        let bottom = nameLabel.frame.origin.y + nameLabel.frame.height
        size = searchDescriptionLabel.text!.sizeWithAttributes ([NSFontAttributeName:  searchDescriptionLabel.font])
        searchDescriptionLabel.frame = CGRect (origin: CGPoint (x: xPos, y: bottom + 5), size: size)
    }
    
    /// <summary>
    /// Sets the highlighted.
    /// </summary>
    /// <param name="highlighted">If set to <c>true</c> highlighted.</param>
    /// <param name="animated">If set to <c>true</c> animated.</param>
    override func setHighlighted (highlighted: Bool, animated: Bool)
    {
        if highlighted
        {
            // for all menu items, set the title color to be highlighted
            nameLabel.textColor = UniversalResources.UI_APP_COLOR_TINT
            searchDescriptionLabel.textColor = UniversalResources.UI_APP_COLOR_TINT
        }
        else
        {
            // for all menu items, set the title color to be unhighlighted
            nameLabel.textColor = UIColor.blackColor()
            searchDescriptionLabel.textColor = UIColor.grayColor()
        }
    }
    
    
    
    
    
    // MARK: - all functions that relate to the internal class
    
    /// <summary>
    /// Updates the cell.
    /// </summary>
    /// <param name="menuTitle">Menu name.</param>
    /// <param name="menuDescription">Menu description.</param>
    /// <param name="menuImage">Menu image.</param>
    func updateCell(menuTitle: String, menuDescription: String, menuImage: UIImage)
    {
        // update the Labels based on the menu item
        nameLabel.text = menuTitle
        searchDescriptionLabel.text = menuDescription
        
        // update the menu Image
        userProfileImageImageView.image = menuImage
    }
}