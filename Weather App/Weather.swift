//
//  Weather.swift
//  Weather App
//
//  Created by Jonathan Thomas on 5/10/16.
//  Copyright © 2016 Jonathan Thomas. All rights reserved.
//

import Foundation

struct Weather {
    let zipcode: String
    let temperature: Int
    
    init(zipcode: String, temperature: Int){
        self.zipcode = zipcode
        self.temperature = temperature
    }
}
