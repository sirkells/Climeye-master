//
//  ViewController.swift
//  Climeye
//
//  Created by Kelechi Igbokwe on 05.01.18.
//  Copyright © 2018 Kelechi Igbokwe. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Creating constants
    var weatherURL = "api.openweathermap.org/data/2.5/weather"
    var apiKey = "199edcc8d65de48371141727196d8b70"
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // locationManager Methods to get location, accuracy and update coordinates
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }


}


