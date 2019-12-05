//
//  ViewController.swift
//  Conversion Calculator
//
//  Created by Michael Woodruff on 12/5/19.
//  Copyright © 2019 Michael Woodruff. All rights reserved.
//

import UIKit

func fahrenheitToCelcius(_ input: String) -> String {
    return String((Float(input)! - Float(32)) * (5/9))
}

func celciusToFahrenheit(_ input: String) -> String {
    return String((Float(input)! * (9/5)) + Float(32))
}

func milesToKm(_ input: String) -> String {
    return String(Float(input)! * 1.609344)
}

func kmToMiles(_ input: String) -> String {
    return String(Float(input)! / 1.609344)
}

struct Converter {
    var label: String
    var inputUnit: String
    var outputUnit: String
    var index: Int
    var conversionFunction: (String) -> String = fahrenheitToCelcius
}

class ConverterViewController: UIViewController {

    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var outputDisplay: UITextField!
    
    var converters = [
        Converter(
            label: "fahrenheit to celcius",
            inputUnit: "°F",
            outputUnit: "°C",
            index: 0,
            conversionFunction: fahrenheitToCelcius
        ),
        Converter(
            label: "celcius to fahrenheit",
            inputUnit: "°C",
            outputUnit: "°F",
            index: 1,
            conversionFunction: celciusToFahrenheit
        ),
        Converter(
            label: "miles to kilometers",
            inputUnit: "mi",
            outputUnit: "km",
            index: 2,
            conversionFunction: milesToKm
        ),
        Converter(
            label: "kilometers to miles",
            inputUnit: "km",
            outputUnit: "mi",
            index: 3,
            conversionFunction: kmToMiles
        ),
    ]
    var selectedConverter: Converter?
    var inputNumber: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        updateConverter(0)
        updateDisplays()
    }
    
    @IBAction func numberHit(_ sender: UIButton) {
        if (inputNumber == "0") {
            inputNumber = sender.currentTitle! as String
        } else if (inputNumber == "-0"){
            inputNumber = "-" + sender.currentTitle! as String
        } else {
            inputNumber = inputNumber + sender.currentTitle! as String
        }
        updateDisplays()
    }
    
    @IBAction func dotHit(_ sender: Any) {
        if (inputNumber.contains(".")) {
            print("already decimal")
            return
        } else {
            inputNumber = inputNumber + "."
        }
        updateDisplays()
    }
    
    @IBAction func plusMinusHit(_ sender: Any) {
        if (inputNumber.contains("-")) {
            inputNumber = String(inputNumber.split(separator: "-")[0])
        } else {
            inputNumber = "-" + inputNumber
        }
        updateDisplays()
    }
    
    func updateDisplays() {
        inputDisplay.text = inputNumber + " " + selectedConverter!.inputUnit
        outputDisplay.text = selectedConverter!.conversionFunction(inputNumber) + " " + selectedConverter!.outputUnit
    }
    
    @IBAction func cHit(_ sender: Any) {
        inputNumber = "0"
        updateDisplays()
    }
    
    func updateConverter(_ index: Int) {
        selectedConverter = converters[index]
        updateDisplays()
    }

    @IBAction func onConverterClick(_ sender: Any) {
        let alert = UIAlertController(
            title: "Choose Converter",
            message: "",
            preferredStyle: UIAlertController.Style.actionSheet
        )
        
        for converter in converters {
            alert.addAction(UIAlertAction(
                title: converter.label,
                style: UIAlertAction.Style.default,
                handler: {
                    (alertAction) -> Void in
                    self.updateConverter(converter.index)
                }
            ))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

