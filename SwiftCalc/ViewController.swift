//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Alexander Scott on 14/04/2015.
//  Copyright (c) 2015 Alexander Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    @IBOutlet weak var operationMethodLabel: UILabel!
    //variable for the calculator
    private var calc : Calculator = Calculator()
    
    //variable to track the number presses before equals
    private var operandSequence : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateDisplay(){
        calculatorLabel.text = String(format:"%.8f", calc.value())
        
        updateOperandDisplay()
        println("Updating Display")
        switch calc.operationType(){
        case .Addition:
            operationMethodLabel.text = "➕"
            break
        case .Subtraction:
            operationMethodLabel.text = "➖"
            break
        case .Multiplication:
            operationMethodLabel.text = "✖️"
            break
        case .Division:
            operationMethodLabel.text = "➗"
            break
        }
    }
    
    private func updateOperandDisplay(){
        //allows us to remove any forwarded padded zeros
        let trimmedValue = (operandSequence as NSString).doubleValue
        operandLabel.text = String(format: "%.8f", trimmedValue)
    }
    
    @IBAction func clearAction(sender: AnyObject) {
        self.calc.reset()
        operandSequence = ""
        updateDisplay()
    }
    
    @IBAction func symbolPressed(sender: UIButton) {
        let symbol = sender.titleLabel?.text ?? ""
        
        switch symbol{
        case "➕":
            calc.setOperationType(Calculator.OperationType.Addition)
            break
        case "➖":
            calc.setOperationType(Calculator.OperationType.Subtraction)
            
            break
        case "✖️":
            calc.setOperationType(Calculator.OperationType.Multiplication)
            
            break
        case "➗":
            calc.setOperationType(Calculator.OperationType.Division)
            break
        default:
            break
        }
        
        if calc.value() == 0.0 && !operandSequence.isEmpty{
            calc.setValue((operandSequence as NSString).doubleValue)
            operandSequence = ""
        }
        
        updateDisplay()
    }
    
    
    @IBAction func valuePressed(sender: UIButton) {
        //Get the button label
        let valueToAppend = sender.titleLabel?.text ?? ""
        var canAppend = false
        
        //if the value is a decimal, check for an already pressed one
        if (valueToAppend == "."){
            
            var charSet = NSCharacterSet(charactersInString: ".");
            var range = (operandSequence as NSString).rangeOfCharacterFromSet(charSet);
            
            if range.location == NSNotFound{
                canAppend = true
            }
        }else{
            canAppend = true
        }
        
        println("\t Value pressed: \(valueToAppend). Appending: \(canAppend)")
        //append if possible to the end of the character sequence
        if canAppend{
            operandSequence += valueToAppend
            updateOperandDisplay()
        }
        
    }
    
    @IBAction func apply(sender: AnyObject) {
        if !operandSequence.isEmpty{
            self.calc.applyOperand((operandSequence as NSString).doubleValue)
            operandSequence = ""
            updateDisplay()
        }
    }
    
}

