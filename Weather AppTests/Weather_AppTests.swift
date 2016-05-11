//
//  Weather_AppTests.swift
//  Weather AppTests
//
//  Created by Jonathan Thomas on 5/9/16.
//  Copyright © 2016 Jonathan Thomas. All rights reserved.
//

import XCTest
@testable import Weather_App

class Weather_AppTests: XCTestCase {
    
    //MARK: Location Tests
    
    
    func testlocationInitialization(){
        
        //Success Case
        
        let newSuccessEntry = Location(zipcode: "33813", Temperature: "78")
        XCTAssertNotNil(newSuccessEntry, "new entry successfully created!")
    
        //Failure case
    
        let lowNumZip = Location(zipcode: "1", Temperature: "76")
        XCTAssertNil(lowNumZip, "too few arguments for zipcode")
    
        //Failure Case
        
        let highNumZip = Location(zipcode: "100000", Temperature: "56")
        XCTAssertNil(highNumZip, "too many arguments for zipcode")
    }
    
}
