//
//  ViewController.swift
//  Conversion Calculator
//
//  Created by Michael Woodruff on 12/5/19.
//  Copyright © 2019 Michael Woodruff. All rights reserved.
//

import UIKit

struct Converter {
    var label: String
    var inputUnit: String
    var outputUnit: String
    var index: Int
}

class ConverterViewController: UIViewController {

    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var outputDisplay: UITextField!
    
    var converters = [
        Converter(
            label: "fahrenheit to celcius",
            inputUnit: "°F",
            outputUnit: "°C",
            index: 0
        ),
        Converter(
            label: "celcius to fahrenheit",
            inputUnit: "°C",
            outputUnit: "°F",
            index: 1
        ),
        Converter(
            label: "miles to kilometers",
            inputUnit: "mi",
            outputUnit: "km",
            index: 2
        ),
        Converter(
            label: "kilometers to miles",
            inputUnit: "km",
            outputUnit: "mi",
            index: 3
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
        print(inputNumber)
        updateDisplays()
    }
    
    @IBAction func dotHit(_ sender: Any) {
        if (inputNumber.contains(".")) {
            print("already decimal")
            return
        } else {
            inputNumber = inputNumber + "."
        }
        print(inputNumber)
        updateDisplays()
    }
    
    @IBAction func plusMinusHit(_ sender: Any) {
        if (inputNumber.contains("-")) {
            inputNumber = String(inputNumber.split(separator: "-")[0])
        } else {
            inputNumber = "-" + inputNumber
        }
        print(inputNumber)
        updateDisplays()
    }
    
    func updateDisplays() {
        inputDisplay.text = inputNumber + " " + selectedConverter!.inputUnit
    }
    
    @IBAction func cHit(_ sender: Any) {
        inputNumber = "0"
        updateDisplays()
    }
    
    func updateConverter(_ index: Int) {
        selectedConverter = converters[index]
        inputDisplay.text = selectedConverter?.inputUnit
        outputDisplay.text = selectedConverter?.outputUnit
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

