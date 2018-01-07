//
//  ViewController.swift
//  Climeye
//
//  Created by Kelechi Igbokwe on 05.01.18.
//  Copyright © 2018 Kelechi Igbokwe. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Creating constants
    var weatherURL = "http://api.openweathermap.org/data/2.5/weather"
    var apiKey = "199edcc8d65de48371141727196d8b70"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // locationManager Methods to get location, accuracy and update coordinates
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method:  .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success, got the weather")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(response.result.error)")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    
    func updateWeatherData(json : JSON) {
        if let tempResult = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(tempResult - 273.15)
            weatherDataModel.cityName = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIcon = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
        }
        else {
            cityLabel.text = "Weather Unavailable"
        }
    }
        
        func updateUIWithWeatherData() {
            cityLabel.text = weatherDataModel.cityName
            tempLabel.text = "\(weatherDataModel.temperature)°C"
            weatherImage.image = UIImage(named: weatherDataModel.weatherIcon)
        }
    



    // the locationManager mtd(startupdating) sends the coordinates to this function
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("Longitude = \(location.coordinate.longitude), Latitude = \(location.coordinate.latitude)")
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            let params : [String : String] = ["lon" : longitude, "lat": latitude, "appid" : apiKey]
            getWeatherData(url: weatherURL, parameters: params)
        
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    
    func userEnteredANewCityName(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : apiKey]
        
        getWeatherData(url: weatherURL, parameters: params)
        
    }
    
    
    //Write the PrepareForSegue Method here
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! CitySearchViewController
            
            
            destinationVC.delegate = self
            
        }
    }



}


