//
//  LocationViewController.swift
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

class LocationViewController: UIViewController, UITextFieldDelegate, WeatherServiceDelegate {
    
// MARK: Properties
    
    let weatherService = WeatherService()
    var globalTemp = ""

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
   
    //This value is either passed by `LocationTableViewController` in `prepareForSegue(_:sender:)` or constructed as part of adding a new location.
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Handle input through delegate callbacks.
        locationTextField.delegate = self
        self.weatherService.delegate = self
        
        // Set up views if editing an existing Location.
        if let location = location {
            navigationItem.title = location.zipcode
            locationTextField.text = location.zipcode
        }
        
        // Enable the Save button only if the text field has a valid Location name.
        checkValidLocationName()
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
    
    func checkValidLocationName() {
        // Disable the Save button if the text field is empty.
        let text = locationTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
// MARK: UITextFieldDelegate
    
    // called when 'return' key pressed. return NO to ignore.
    // Requires having the text fields using the view controller as the delegate.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Sends the keyboard away when pressing the "done" button
        resign()
        return true
    }
    
    //BEGIN EDITING
    
    // When clicking on the field, use this method.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        // Create a button bar for the number pad
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        // Setup the buttons to be put in the system.					
        let item = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: #selector(LocationViewController.endEditingNow) )
        let toolbarButtons = [item]
        
        //Put the buttons into the ToolBar and display the tool bar
        keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
        textField.inputAccessoryView = keyboardDoneButtonView
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    //END EDITING
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidLocationName()
        navigationItem.title = locationTextField.text
        self.weatherService.getWeather(locationTextField.text!)                         ////////////////////////////////////////////////////////////////
        resign()
    }
    

// MARK: WeatherServiceDelegate
    
    func setWeather(weather: Weather) {
        globalTemp = "\(weather.temperature) °"
    }
    
// MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on if its modal or push presentation, this view controller needs to be dismissed in two different ways.
        let isPresentingInAddLocationMode = presentingViewController is UINavigationController
        
        if isPresentingInAddLocationMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(saveButton === sender){
            let zipcode = locationTextField.text ?? ""
            let Temperature = globalTemp  
            
            // Set the location to be passed to LocationTableViewController after the unwind segue.
            location = Location(zipcode: zipcode, Temperature: Temperature)
        }
    }    
}

