//
//  ViewController.swift
//  calculator
//
//  Created by RAOMACBOOK on 3/30/15.
//  Copyright (c) 2015 Xtoid LLC. All rights reserved.
//
// CODE UPDATES NEEDED FOR FULL FUNCTIONALITY of THE CALCULATOR

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    // use ! to unwrap. Display will never be nil so no need to unwrap in future if ! used here. Called implicitly unwrapped optional
    
    var userIsInTheMiddleOfTypingNumber: Bool = false
    
    //The code below is the green arrow that goes from "controller" to the "model" in the MVC diagram
    
    var brain = CalculatorBrain()
    
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
        if userIsInTheMiddleOfTypingNumber  {
            enter()
         }
          if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 999 //consider displaying error here, instead of 999 ?
            }
        }
    }

    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 999 //consider displaying error here, instead of 999 ?
        }
    }
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
}

