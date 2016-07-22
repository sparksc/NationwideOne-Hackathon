//
//  LoadingAlertViewController.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/21/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class LoadingAlertViewController: UIViewController
{
    // MARK: - all fields that relate private accessing
    
    // the frame size that will hold the frame size that will be used for adjusting the View
    private var adjustmentFrameSize: CGRect!
    
    // the Label that will hold a text about the title for the View
    private var titleLabel: UILabel!
    
    // the Button that will display a blur View over the screen
    private var blurEffectButton: UIButton!
    
    // the Activity Indicator View that shows the status of loading
    private var activityLoader: UIActivityIndicatorView!
    
    // the Views that will hold the style one View
    private var styleTwoView: UIView!
    
    // a Boolean that will determine if the View is closing
    private var closing = false
    
    // the String that holds the current style
    private var currentStyle = ""
    
    
    
    // MARK: - all functions that relate to the View Controller super class
    
    /// <summary>
    /// The function that gets called when the View loads.
    /// </summary>
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set the status bar style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        // sets up the View to not extend under navigation bar top
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    /// <summary>
    /// The function that gets called when the View will appear.
    /// </summary>
    /// <param name="animated">If set to <c>true</c> animated.</param>
    override func viewWillAppear (animated: Bool)
    {
        super.viewWillAppear (animated)
        
        // set the top View Controller
        UniversalResources.TOP_VC = "LoadingAlertViewController"
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
    /// Checks if View is loaded
    /// </summary>
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews ()
        
        // if the View is not closing, then set the adjustments
        if !closing
        {
            // if the frame size has not been set yet
            if adjustmentFrameSize != nil
            {
                view.frame = CGRect (x: 0, y: 0, width: 0, height: 0)
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
    
    
    
    // MARK: - all functions that relate to the internal class for public accessing
    
    /// <summary>
    /// Closes the View
    /// </summary>
    func closeView()
    {
        // show the View is closing
        closing = true
        
        dismissViewControllerAnimated (true) {
            // go back to View Controller that this View Controller was called from
        }
    }
    
    /// <summary>
    /// Sets up the Style One View
    /// Style 1 (loading animation, black transparent background with a loading spinner)
    /// </summary>
    func setUpStyleOneView()
    {
        // if the adjustment frame size has not been set up yet
        if adjustmentFrameSize == nil
        {
            // set the frame size
            adjustmentFrameSize = CGRect (x: 0, y: 0, width: 0, height: 0)
        }
        
        // set the current style
        currentStyle = "Style 1"
        
        
        // set up the blur effect to become black and add to the View
        blurEffectButton = UIButton(type: UIButtonType.Custom)
        blurEffectButton.backgroundColor = UIColor.whiteColor()
        blurEffectButton.alpha = 0.75
        blurEffectButton.enabled = true
        blurEffectButton.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        blurEffectButton.backgroundColor = UIColor.blackColor()
        
        // animate the alpha
        UIView.animateWithDuration(UniversalResources.UNIVERSAL_ANIMATION_DURATION, animations: {
            self.blurEffectButton.alpha = 0.5
        })
        
        // set up the Activity Indicator View
        activityLoader = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityLoader.frame = CGRect(x: UIScreen.mainScreen().bounds.width/2 - 20, y: UIScreen.mainScreen().bounds.height/2 - 20, width: 40, height: 40)
        activityLoader.startAnimating()
        
        // add the subViews to the View
        view.addSubview(blurEffectButton)
        view.addSubview(activityLoader)
    }
    
    /// <summary>
    /// Sets up the View
    /// Style 2 (loading animation, with a title and a loading spinner)
    /// </summary>
    /// <param name="title"> The title.</param>
    func setUpStyleTwoView(title: String)
    {
        // if the adjustment frame size has not been set up yet
        if adjustmentFrameSize == nil
        {
            // set the frame size
            adjustmentFrameSize = CGRect (x: 0, y: 0, width: 0, height: 0)
        }
        
        // set the current style
        currentStyle = "Style 2"
        
        // width of the View
        let width = UIScreen.mainScreen().bounds.width/2
        
        // set up the view for the pickup/delivery information
        let frame = CGRect (x: UIScreen.mainScreen().bounds.width/2 - width/2, y: UIScreen.mainScreen().bounds.height/2 - 35, width: UIScreen.mainScreen().bounds.width/2, height: 120)
        styleTwoView = UIView (frame: frame)
        styleTwoView.backgroundColor = UIColor.whiteColor()
        styleTwoView.layer.borderColor = UniversalResources.CG_APP_COLOR_TINT
        styleTwoView.layer.cornerRadius = 10
        styleTwoView.layer.borderWidth = 5
        
        // set up the blur effect to become black and add to the View
        blurEffectButton = UIButton(type: UIButtonType.Custom)
        blurEffectButton.backgroundColor = UIColor.whiteColor()
        blurEffectButton.alpha = 0.75
        blurEffectButton.enabled = true
        blurEffectButton.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        blurEffectButton.backgroundColor = UIColor.blackColor()
        
        // animate the alpha
        UIView.animateWithDuration(UniversalResources.UNIVERSAL_ANIMATION_DURATION, animations: {
            self.blurEffectButton.alpha = 0.5
        })
        
        // set up the title Label
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont (name: UniversalResources.FONT_NAME_REGULAR, size: 12)
        var size = titleLabel.text!.sizeWithAttributes ([NSFontAttributeName: titleLabel.font])
        titleLabel.numberOfLines = 1
        titleLabel.frame = CGRect(origin: CGPoint(x: styleTwoView.frame.width/2 - size.width/2, y: 10), size: size)
        
        // width limit of the text
        let limit: CGFloat = 3*styleTwoView.frame.width/4
        
        // number of lines
        let lines = ceil(size.width / limit)
        
        // if the width is too large add multiple lines
        if size.width > limit
        {
            // update the size and frame
            size.width = limit
            size.height = size.height * lines
            titleLabel.numberOfLines = Int(lines)
            titleLabel.frame = CGRect(x: styleTwoView.frame.width/2 - size.width/2, y: 10, width: size.width, height: size.height)
        }
        
        // set up the Activity Indicator View
        activityLoader = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityLoader.frame = CGRect(x: styleTwoView.frame.width/2 - 10, y: styleTwoView.frame.height/2 - 10, width: 20, height: 20)
        activityLoader.color = UIColor.blackColor()
        activityLoader.startAnimating()
        
        
        // add the subViews to the View
        styleTwoView.addSubview(titleLabel)
        styleTwoView.addSubview(activityLoader)
        view.addSubview(blurEffectButton)
        view.addSubview(styleTwoView)
    }
    
    /// <summary>
    /// Switches the title
    /// </summary>
    /// <param name="newTitle"> The title.</param>
    func changeTitle(newTitle: String)
    {
        // if the current style is 2, make the change
        if currentStyle == "Style 2"
        {
            // change the title and update the size
            titleLabel.text = newTitle
            var size = titleLabel.text!.sizeWithAttributes ([NSFontAttributeName: titleLabel.font])
            titleLabel.numberOfLines = 1
            titleLabel.frame = CGRect(origin: CGPoint(x: styleTwoView.frame.width/2 - size.width/2, y: 10), size: size)
            
            // width limit of the text
            let limit: CGFloat = 3*styleTwoView.frame.width/4
            
            // number of lines
            let lines = ceil(size.width / limit)
            
            // if the width is too large add multiple lines
            if size.width > limit
            {
                // update the size and frame
                size.width = limit
                size.height = size.height * lines
                titleLabel.numberOfLines = Int(lines)
                titleLabel.frame = CGRect(x: styleTwoView.frame.width/2 - size.width/2, y: 10, width: size.width, height: size.height)
            }
        }
    }
}