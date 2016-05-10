//
//  Location.swift
//  Weather App
//
//  Created by Jonathan Thomas on 5/10/16.
//  Copyright © 2016 Jonathan Thomas. All rights reserved.
//

import UIKit

class Location: NSObject, NSCoding {
    
    //MARK: Properties
    
    var zipcode: String
    var Temperature: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("locations")
    //MARK: Types
    
    struct PropertyKey {
        static let zipcodeKey = "zipcode"
        static let temperatureKey = "temperature"
    }
    
    //MARK: Initialization
    
    init?(zipcode: String, Temperature: String){
        
        //Initialize properties
        self.zipcode = zipcode
        self.Temperature = Temperature
        
        super.init()
        
        //zipcodes should be 5 digits in length
        if(zipcode.characters.count != 5){
            return nil
        }
    }
    
    //MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(zipcode, forKey: PropertyKey.zipcodeKey)
        aCoder.encodeObject(Temperature, forKey: PropertyKey.temperatureKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let zipcode = aDecoder.decodeObjectForKey(PropertyKey.zipcodeKey) as! String
        let Temperature = aDecoder.decodeObjectForKey(PropertyKey.temperatureKey) as! String
        
        // Must call designated initializer.
        self.init(zipcode: zipcode, Temperature: Temperature)
    }
}
