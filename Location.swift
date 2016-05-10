//
//  Location.swift
//  Weather App
//
//  Created by Jonathan Thomas on 5/10/16.
//  Copyright © 2016 Jonathan Thomas. All rights reserved.
//

import UIKit

class Location {
    
    //MARK: Properties
    
    var zipcode: String
    var Temperature: String
    
    //MARK: Initialization
    
    init?(zipcode: String, Temperature: String){
        
        //Initialize properties
        self.zipcode = zipcode
        self.Temperature = Temperature
        
        //zipcodes should be 5 digits in length
        if(zipcode.characters.count != 5){
            return nil
        }
    }
}
