//
//  ChangeCityViewController.swift
//  Weather
//
//  Created by liroy yarimi on 26.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

//Write the protocol declaration here:
protocol ChangeCityDelegate {
    func uerEnteredANewCityName(city : String)
}


class ChangeCityViewController: UIViewController {
    
    //Declare the delegate variable here:
    var delegate : ChangeCityDelegate?
    
    //This is the pre-linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!
    
    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        //1 Get the city name the user entered in the text field
        if let cityName = changeCityTextField.text{
            //print("cityName : \(cityName)" )
            if cityName != ""{
                //2 If we have a delegate set, call the method userEnteredANewCityName
                delegate?.uerEnteredANewCityName(city: cityName) // equal to: if delegate != nill {delegate.uerEnteredANewCityName(city: cityName)}
                
                //3 dismiss the Change City View Controller to go back to the WeatherViewController
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Change bar status to light color
    /***************************************************************/
    
    //for making the status bar white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

