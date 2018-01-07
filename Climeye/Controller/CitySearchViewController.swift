//
//  CitySearchViewController.swift
//  Climeye
//
//  Created by Kelechi Igbokwe on 05.01.18.
//  Copyright © 2018 Kelechi Igbokwe. All rights reserved.
//

import UIKit
protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class CitySearchViewController : UIViewController {
    
     var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var citySearchLabel: UITextField!
    @IBAction func searchButton(_ sender: UIButton) {
        
        let cityName = citySearchLabel.text!
        
        delegate?.userEnteredANewCityName(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
