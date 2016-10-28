//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Wayne Rumble on 11/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit

import Foundation

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    var farenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = farenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isReallyLabel: UILabel!
    @IBOutlet weak var degreesCelsiusLabel: UILabel!
    @IBOutlet weak var degreesFarenheitLabel: UILabel!
    
    @IBAction func farenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, value = Double(text) {
            farenheitValue = value
        } else {
            farenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        let hour = NSCalendar.currentCalendar().component(NSCalendarUnit.Hour, fromDate: NSDate())
        print(hour)
        if (hour > 20 || hour < 6) {
            view.backgroundColor = UIColor.blackColor()
            self.isReallyLabel.textColor = UIColor.whiteColor()
            self.degreesCelsiusLabel.textColor = UIColor.redColor()
            self.degreesFarenheitLabel.textColor = UIColor.redColor()
            self.celsiusLabel.textColor = UIColor.redColor()
            self.textField.attributedPlaceholder = NSAttributedString(string: "Value", attributes: [NSForegroundColorAttributeName: UIColor.orangeColor()])

        } else {
            view.backgroundColor = UIColor(red: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                            green: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                            blue: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                            alpha: 1.0)
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool {
        let existingTextHasDecimal = textField.text?.rangeOfString(".")
        let replacementTextHasDecimal = string.rangeOfString(".")
        let replacementTextAllCharacters = NSCharacterSet(charactersInString: string)
        let replacementTextOnlyDigits = NSCharacterSet.decimalDigitCharacterSet().isSupersetOfSet(replacementTextAllCharacters)
        
        if replacementTextHasDecimal != nil && existingTextHasDecimal != nil {
            return false
        }else{
            if replacementTextOnlyDigits {
                return true
            }else if replacementTextHasDecimal != nil{
                return true
            }else{
                return false
            }
        }
    }
}