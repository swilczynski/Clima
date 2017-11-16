//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userChangedCity(city: String)
}

class ChangeCityViewController: UIViewController {
    var delegate: ChangeCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        if let cityName = self.changeCityTextField.text {
            if cityName != "" {
                self.delegate?.userChangedCity(city: cityName)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.changeCityTextField.layer.cornerRadius = 6.0
                self.changeCityTextField.layer.borderWidth = 1.0
                self.changeCityTextField.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
