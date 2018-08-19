//
//  ViewController.swift
//  Weather
//
//  Created by liroy yarimi on 25.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit
import CoreLocation //library for GPS
//this two library to get data from website (cocoapods)
import Alamofire
import SwiftyJSON
import SVProgressHUD

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {

    //Constants
    //it write "http" and not "https" because the API don't support SSL (now it do but when we write the code it doesn't)
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather" //we can see it at all the example in the website
    var APP_ID = "" //get it when you log in to the website

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager() //create object from the GPS library
    var weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cityLabel.isEnabled = false
        updateAPP_ID()
        print("APP_ID : \(APP_ID)")
        restart()
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    
    //get data from website server
    func getWeatherData(url : String, parameters : [String:String]){ //don't foreget IMPORT
        
        //make a request from website witg the right parameters.
        //the result is in the variable response
        Alamofire.request(url , method : .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess{ //check if we get succeed in the process
                print("Success! Got the weather data")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                SVProgressHUD.dismiss()
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                SVProgressHUD.dismiss()
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    //update data in are variable and screen
    func updateWeatherData(json : JSON){
        // to read the value of json (weatherJSON) go to jsoneditoronline website.
        // json["main"]["temp"] - this is dectionary read with 2 keys and .double is for get type of double
        
        
        
        if let tempResult = json["main"]["temp"].double { //if the temp isn't nil then all the rest isn't nil
            //print(tempResult)
            
            let temperature = Int(tempResult - 273.15)
            let city = (json["name"]).stringValue
            let condition = json["weather"][0]["id"].intValue
            let weatherIconName = weatherDataModel.updateWeatherIcon(condition: condition)
            
            weatherDataModel = WeatherDataModel(newTemperature: temperature, newCondition: condition, newCity: city, newWeatherIconName: weatherIconName)
            
            updateUIWithWeatherData()
        }
        else{
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    func updateUIWithWeatherData(){
        cityLabel.text = weatherDataModel.getCity()
        temperatureLabel.text = "\(weatherDataModel.getTemperature())°"
        weatherIcon.image = UIImage(named: weatherDataModel.getWeatherIconName())
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    // function that call if we found are location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1] //are last location is the last in the array
        
        if location.horizontalAccuracy > 0 { //check if are value is valid
            
            locationManager.stopUpdatingLocation() // then stop search a location because you find it.
            //are class stop getting messagess from the library CoreLocation
            locationManager.delegate = nil //its for to gets the data one time (because its take some time to stop the stopUpdatingLocation)
            
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            //to know the right structure we need to get the website and there it's write. (press example link and look at up at server address
            //to get update example)
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    //func that call  if we not(!) found are location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    func uerEnteredANewCityName(city : String){
        let params : [String : String] = ["q" : city, "appid" : APP_ID] //very specific buil (API)
        getWeatherData(url: WEATHER_URL, parameters: params)
        
    }
    
    
    //this function called when the segue is prees
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! ChangeCityViewController //create object of type "ChangeCityViewController"
            destinationVC.delegate = self //this order tell the protocol that we (class WeatherViewController) want to be your "enturn". it's mean
        }
        
    }
    
    
    //restart the app with GPS location (and get update weather)
    @IBAction func refreshButtonPress(_ sender: Any) {
        SVProgressHUD.show()
        restart()
    }
    
    
    /*
     The number one function. search are location.
     if it found, then call the function func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
     and if didn't found then call func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
     */
    func restart(){
        locationManager.delegate = self
        // this line is to get our location with redios of hundred meters (its the best for our app - weather) if we do a deffrent app we probable need a diffrent radios.
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // a little message that ask the user location when use the app
        //the value of the message is in the two keys in the info.plist file.
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() // start looking for location (on the background)
    }


    
    
    
    //MARK: - Gets APP_ID value from Keys.plist
    /***************************************************************/
    
    
    //this function update the variable APP_ID
    func updateAPP_ID(){
        if let tempValue = readFromPlist(plistName: "Keys", key: "APP_ID"){
            APP_ID = tempValue
        }
        else{
            print("Error: the key or plist name is wrong")
        }
    }
    
    
    //this function read from Keys.plist and return the value of APP_ID.
    func readFromPlist(plistName : String, key : String) -> String?{
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: plistName, ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict { //dict have all the plist
            print(dict)
            if let value = dict[key] as? String {//get the value of key newAPI
                //do something with your value
                //print(value)
                return value
            }
        }
        return nil
    }
    
    //MARK: - Change bar status to light color
    /***************************************************************/
    
    //for making the status bar white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

