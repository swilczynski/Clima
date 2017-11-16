//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Angela Yu on 24/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class WeatherData {
    
    var temperature: Int = 0
    var city: String = ""
    var weatherIconName = ""
    
    var condition: Int = 0 {
        didSet {
            self.updateWeatherIcon(condition: condition)
        }
    }

    func updateWeatherIcon(condition: Int) {
        var icon = ""
        
        switch (condition) {
            case 0...300 :
                icon = "tstorm1"
            
            case 301...500 :
                icon = "light_rain"
            
            case 501...600 :
                icon = "shower3"
            
            case 601...700 :
                icon = "snow4"
            
            case 701...771 :
                icon = "fog"
            
            case 772...799 :
                icon = "tstorm3"
            
            case 800 :
                icon = "sunny"
            
            case 801...804 :
                icon = "cloudy2"
            
            case 900...903, 905...1000  :
                icon = "tstorm3"
            
            case 903 :
                icon = "snow5"
            
            case 904 :
                icon = "sunny"
            
            default :
                icon = "dunno"
        }
        
        self.weatherIconName = icon
    }
}
