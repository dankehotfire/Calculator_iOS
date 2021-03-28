//
//  ViewController.swift
//  Calculator
//
//  Created by Danil Nurgaliev on 27.03.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    var firstDigitEntered = false
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var typeOfOperation = ""
    var currentInput: Double {
        get {
            return Double(resultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let arrayValue = value.components(separatedBy: ".")
            if arrayValue[1] == "0" {
                resultLabel.text = "\(arrayValue[0])"
            } else {
                resultLabel.text = "\(newValue)"
            }
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let number = sender.currentTitle else { return }
        
        if firstDigitEntered {
            if resultLabel.text!.count < 9 {
                resultLabel.text = resultLabel.text! + number
            }
        } else {
            resultLabel.text = number
            firstDigitEntered = true
        }
    }
    
    @IBAction func twoNumbersOperation(_ sender: UIButton) {
        typeOfOperation = sender.currentTitle!
        firstNumber = currentInput
        firstDigitEntered = false
    }
    
    @IBAction func signEquallyPressed(_ sender: UIButton) {
        secondNumber = currentInput
        firstDigitEntered = false
        
        switch typeOfOperation {
        case "+":
            operationOnTwoNumbers { $0 + $1 }
        case "-":
            operationOnTwoNumbers { $0 - $1 }
        case "*":
            operationOnTwoNumbers { $0 * $1 }
        case "/":
            operationOnTwoNumbers { $0 / $1 }
        default:
            break
        }
    }
    
    @IBAction func allClearButtonPressed(_ sender: UIButton) {
        currentInput = 0
        firstNumber = 0
        secondNumber = 0
        typeOfOperation = ""
        firstDigitEntered = false
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        if resultLabel.text == "0" || resultLabel.text == "0.0" {
            resultLabel.text = "0"
        } else {
            currentInput = -currentInput
        }
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        currentInput /= 100
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if (resultLabel.text!.contains(".")) {
            resultLabel.text = resultLabel.text
        } else {
            resultLabel.text! += "."
        }
    }
    
    func operationOnTwoNumbers(numbers: (Double, Double) -> Double) {
        currentInput = numbers(firstNumber,secondNumber)
    }
}

