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
    
    var zipcode: Int
    var Temperature: Int
    
    //MARK: Initialization
    
    init?(zipcode: Int, Temperature: Int){
        
        //Initialize properties
        self.zipcode = zipcode
        self.Temperature = Temperature
        
        //zipcodes should be 5 digits in length
        if(zipcode > 99999 || zipcode < 10000){
            return nil
        }
    }
}
