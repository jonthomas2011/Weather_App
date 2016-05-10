//
//  ViewController.swift
//  Weather App
//
//  Created by Jonathan Thomas on 5/9/16.
//  Copyright © 2016 Jonathan Thomas. All rights reserved.
//

/* FUNCTIONALITY
-  Allows the user to add a zip code to a table / list
-  Allows the user to select a zip code and see the current temperature using the OpenWeatherMap API (you may use “3b535043693316ba125a0513276aa62d” for the key or sign up for your own)
-  Shows the location on a map with the current temperature in the map pin
-  Allows the user to set a preference for ºC or ºF
*/

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
// MARK: Properties

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Handle the text field’s user input through delegate callbacks.
        locationTextField.delegate = self
        
    }

// MARK: Helper Methods
    
    // This is called to remove the first responder for the text field.
    func resign() {
        self.resignFirstResponder()
    }
    
    // This triggers the textFieldDidEndEditing method that has the textField within it.
    //  This then triggers the resign() method to remove the keyboard.
    //  We use this in the "done" button action.
    func endEditingNow(){
        self.view.endEditing(true)
    }
    
// MARK: UITextFieldDelegate
    
    // called when 'return' key pressed. return NO to ignore.
    // Requires having the text fields using the view controller as the delegate.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Sends the keyboard away when pressing the "done" button
        resign()
        return true
        
    }
    
    // When clicking on the field, use this method.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        
        // Create a button bar for the number pad
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        // Setup the buttons to be put in the system.
        let item = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: #selector(ViewController.endEditingNow) )
        let toolbarButtons = [item]
        
        //Put the buttons into the ToolBar and display the tool bar
        keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
        textField.inputAccessoryView = keyboardDoneButtonView
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //locationTextField.text = textField.text
        resign()
    }

// MARK: Actions

    @IBAction func addNewLocation(sender: AnyObject) {
        locationLabel.text = "New Location Added!"
    }
    
}

