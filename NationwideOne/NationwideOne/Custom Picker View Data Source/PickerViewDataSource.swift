//
//  PickerViewDataSource.swift
//  NationwideOne
//
//  Created by Cameron Hopkins on 7/22/16.
//  Copyright © 2016 Cameron Hopkins. All rights reserved.
//

import Foundation
import UIKit

class PickerViewDataSource: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    // MARK: - all fields that relate to the Picker View
    @IBOutlet var pickerView: UIPickerView!
    
    // the Array of Strings that holds the key values for the Array
    var pickerViewData: [String] = []
    
    // the Text View to set the Picker View selection to
    var pickerTextView: UITextView!
    
    
    // MARK: - all functions that relate to the the Table View Data Source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    /// <summary>
    /// Gets the number of columns in the Picker View
    /// </summary>
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        // return the number of columns
        return 1
    }
    
    /// <summary>
    /// Gets the number of rows in the Picker View
    /// </summary>
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // return the number of columns
        return pickerViewData.count
    }
    
    /// <summary>
    /// Gets the row and component (column) that's being passed in
    /// </summary>
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // return the row and component (column) that's being passed in
        return pickerViewData[row]
    }
    
    
    /// <summary>
    /// Called when a row is selected
    /// </summary>
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        // pickerTextView.text = pickerViewData[row]
    }
}