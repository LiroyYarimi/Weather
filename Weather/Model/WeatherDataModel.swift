//
//  WeatherDataModel.swift
//  Weather
//
//  Created by liroy yarimi on 26.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class WeatherDataModel {
    
    //Declare your model variables here
    //private var temperature : Int
    private var temperature:Int
    private var condition : Int
    private var city : String
    private var weatherIconName : String
    
    init() {
        temperature = 0
        condition = 0
        city = ""
        weatherIconName = ""
    }
    
    init(newTemperature : Int, newCondition: Int, newCity:String, newWeatherIconName: String) {
        temperature = newTemperature
        condition = newCondition
        city = newCity
        weatherIconName = newWeatherIconName
    }

    func getTemperature() -> Int{
        return temperature
    }
    func getCondition() -> Int{
        return condition
    }
    func getCity() -> String{
        return city
    }
    func getWeatherIconName() -> String{
        return weatherIconName
    }

    func setTemperature(newTemperature : Int){
        temperature = newTemperature
    }
    func setCondition(newCondition: Int) {
        condition = newCondition
    }
    func setCity(newCity:String){
        city = newCity
    }
    func setWeatherIconName(newWeatherIconName: String){
        weatherIconName = newWeatherIconName
    }
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        //from https://openweathermap.org/weather-conditions
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
}
