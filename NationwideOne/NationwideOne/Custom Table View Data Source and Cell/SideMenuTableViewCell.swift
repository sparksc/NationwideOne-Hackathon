//
//  SideMenuTableViewCell.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class SideMenuTableViewCell: UITableViewCell
{
    // MARK: - all fields that relate to the internal class for public accessing
    
    // the Label to describe the title of the menu item
    var menuTitleLabel: UILabel!
    
    // the Label to describe the description of the menu item
    var menuDescriptionLabel: UILabel!
    
    // the Image View to describe the image of the menu item
    var menuImageView: UIImageView!
    
    
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
        menuTitleLabel = UILabel ()
        menuTitleLabel.font = UIFont (name: UniversalResources.FONT_NAME_BOLD, size: 14)
        menuTitleLabel.textColor = UIColor.blackColor()
        menuTitleLabel.backgroundColor = UIColor.clearColor()
        
        menuDescriptionLabel = UILabel ()
        menuDescriptionLabel.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 12)
        menuDescriptionLabel.textColor = UIColor.blackColor()
        menuDescriptionLabel.backgroundColor = UIColor.clearColor()
        
        // set up the Image View of the menu item
        menuImageView = UIImageView ()
        menuImageView.backgroundColor = UIColor.clearColor()
        
        // add the subviews
        contentView.addSubview(menuTitleLabel)
        contentView.addSubview(menuDescriptionLabel)
        contentView.addSubview(menuImageView)
    }
    
    
    /// <summary>
    /// Layouts the subviews.
    /// </summary>
    override func layoutSubviews()
    {
        super.layoutSubviews ()
        
        // position the frame for the menu image
        menuImageView.frame = CGRectMake(10, contentView.bounds.height/2 - 10, 20, 20)
        
        // the x position for the title and description
        let xPos = menuImageView.frame.origin.x + menuImageView.frame.width + 10
        
        // position the frame for the name
        var size: CGSize = menuTitleLabel.text!.sizeWithAttributes ([NSFontAttributeName:  menuTitleLabel.font])
        menuTitleLabel.frame = CGRect (origin: CGPoint (x: xPos, y: 5), size: size)
        
        // position the frame for the description
        let bottom = menuTitleLabel.frame.origin.y + menuTitleLabel.frame.height
        size = menuDescriptionLabel.text!.sizeWithAttributes ([NSFontAttributeName:  menuDescriptionLabel.font])
        menuDescriptionLabel.frame = CGRect (origin: CGPoint (x: xPos, y: bottom + 5), size: size)
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
            menuTitleLabel.textColor = UniversalResources.UI_APP_COLOR_TINT
            menuDescriptionLabel.textColor = UniversalResources.UI_APP_COLOR_TINT
        }
        else
        {
            // for all menu items, set the title color to be unhighlighted
            menuTitleLabel.textColor = UIColor.blackColor()
            menuDescriptionLabel.textColor = UIColor.grayColor()
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
        menuTitleLabel.text = menuTitle
        menuDescriptionLabel.text = menuDescription
        
        // update the menu Image
        menuImageView.image = menuImage
    }
    
}