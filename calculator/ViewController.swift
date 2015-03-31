//
//  ViewController.swift
//  calculator
//
//  Created by RAOMACBOOK on 3/30/15.
//  Copyright (c) 2015 Xtoid LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    // use ! to unwrap. Display will never be nil so no need to unwrap in future if ! used here. Called implicitly unwrapped optional
    
    var userIsInTheMiddleOfTypingNumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        // ! unwraps the "optional" property of sender
        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
       // println("digit = \(digit)")
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
            if userIsInTheMiddleOfTypingNumber  {
            enter()
        }
        
        switch operation {
        case "✖️": performOperation { $0 * $1 }
        case "➗": performOperation { $1 / $0 }
        case "➕": performOperation { $0 + $1 }
        case "➖": performOperation { $1 - $0 }
        case "✔️": performOperation2 { sqrt($0) }
        default: break
        // These above style is called using closures
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
        
    }
    
    func performOperation2(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack: Array<Double> = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        //println("operandStack = \(operandStack)")
    }
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    
    }
}

