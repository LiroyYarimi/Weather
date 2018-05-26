//
//  ViewController.swift
//  Weather
//
//  Created by liroy yarimi on 25.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class WeatherViewController : UIViewController {

    //Constants
    //it write "http" and not "https" because the API don't support SSL (now it do but when we write the code it doesn't)
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather" //we can see it at all the example in the website
    //let APP_ID = "e72ca729af228beabd5d20e3b7749713" // the orginal app id
    var APP_ID = "" //get it when you log in to the website

    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateAPP_ID()
        print("APP_ID : \(APP_ID)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
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
}

