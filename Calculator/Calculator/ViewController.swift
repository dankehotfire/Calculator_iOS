//
//  ViewController.swift
//  Calculator
//
//  Created by Danil Nurgaliev on 27.03.2021.
//

import UIKit

class ViewController: UIViewController {
    private var firstDigitEntered = false
    private var firstNumber: Double = 0
    private var secondNumber: Double = 0
    private var typeOfOperation = ""
    private var currentInput: Double {
        get {
            guard let text = resultLabel.text, let resultLabelText = Double(text) else {
                return 0
            }
            return resultLabelText
        }
        set {
            if typeOfOperation == "/" && secondNumber == 0 {
                resultLabel.text = "Not a number"
            } else {
                let value = "\(newValue)"
                let arrayValue = value.components(separatedBy: ".")
                if arrayValue[1] == "0" {
                    resultLabel.text = "\(arrayValue[0])"
                } else {
                    resultLabel.text = "\(newValue)"
                }
            }
        }
    }
    @IBOutlet private weak var resultLabel: UILabel!

    @IBAction private func numberPressed(_ sender: UIButton) {
        guard let number = sender.currentTitle, let resultLabelText = resultLabel.text else {
            return
        }

        if firstDigitEntered {
            if resultLabelText.count < 9 {
                resultLabel.text = resultLabelText + number
            }
        } else {
            resultLabel.text = number
            firstDigitEntered = true
        }
    }

    @IBAction private func twoNumbersOperation(_ sender: UIButton) {
        guard let senderCurrentTitle = sender.currentTitle else {
            return
        }

        typeOfOperation = senderCurrentTitle
        firstNumber = currentInput
        firstDigitEntered = false
    }

    @IBAction private func signEquallyPressed(_ sender: UIButton) {
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

    @IBAction private func allClearButtonPressed(_ sender: UIButton) {
        currentInput = 0
        firstNumber = 0
        secondNumber = 0
        typeOfOperation = ""
        firstDigitEntered = false
    }

    @IBAction private func plusMinusButtonPressed(_ sender: UIButton) {
        if resultLabel.text == "0" || resultLabel.text == "0.0" {
            resultLabel.text = "0"
        } else {
            currentInput = -currentInput
        }
    }

    @IBAction private func percentageButtonPressed(_ sender: UIButton) {
        currentInput /= 100
    }

    @IBAction private func dotButtonPressed(_ sender: UIButton) {
        guard var resultLabelText = resultLabel.text else {
            return
        }

        if resultLabelText.contains(".") {
            resultLabel.text = resultLabel.text
        } else {
            resultLabelText += "."
        }
    }

    private func operationOnTwoNumbers(numbers: (Double, Double) -> Double) {
        currentInput = numbers(firstNumber, secondNumber)
    }
}
