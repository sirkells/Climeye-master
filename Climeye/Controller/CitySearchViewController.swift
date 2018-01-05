//
//  CitySearchViewController.swift
//  Climeye
//
//  Created by Kelechi Igbokwe on 05.01.18.
//  Copyright © 2018 Kelechi Igbokwe. All rights reserved.
//

import UIKit
class CitySearchViewController : UIViewController {
    
    @IBOutlet weak var citySearchLabel: UITextField!
    @IBAction func searchButton(_ sender: UIButton) {
    }
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
