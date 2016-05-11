//
//  WeatherService.swift
//  Weather App
//
//  Created by Jonathan Thomas on 5/10/16.
//  Copyright © 2016 Jonathan Thomas. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
}

class WeatherService {
    
    //MARK: Properties
    
    var delegate: WeatherServiceDelegate?
    
    //MARK: Actions
    
    func getWeather(zipcode: String){
        
        let path = "http://api.openweathermap.org/data/2.5/weather?zip=\(zipcode),us&appid=3b535043693316ba125a0513276aa62d"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            let json = JSON(data: data!)
            let temperatureK = json["main"]["temp"].double
            let temperatureC = temperatureK! - 273.15
            let temperatureF = (temperatureC * 1.8) + 32
            
            let weather = Weather(zipcode: zipcode, temperature: Int(temperatureF))
            
            if self.delegate != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setWeather(weather)
                })
            }
        }
        
        task.resume()
    }
}
