//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Carter Schofield on 8/28/23.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
//        print("Current text: \(String(describing: textField.text))")
//        print("Replacement text: \(string)")
//
//        return true
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil,
           replacementTextHasDecimalSeparator != nil{
            return false
        } else{
            return true
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let f = fahrenheitValue {
            return f.converted(to: .celsius)
        } else{
            return nil
        }
    }
    
    func updateCelsiusLabel(){
        if let c = celsiusValue{
//            celsiusLabel.text = "\(c.value)"
            celsiusLabel.text =
                numberFormatter.string(from: NSNumber(value: c.value))
        } else{
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        updateCelsiusLabel()
        
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text){
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else{
            fahrenheitValue = nil
        }
//        if let text = textField.text, !text.isEmpty{
//            celsiusLabel.text = text
//        } else{
//            celsiusLabel.text = "???"
//        }
    }
    @IBAction func dismissKeyboard(_ send: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
