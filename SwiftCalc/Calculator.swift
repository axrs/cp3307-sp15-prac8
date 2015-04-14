//
//  Calculator.swift
//  SwiftCalc
//
//  Created by Alexander Scott on 14/04/2015.
//  Copyright (c) 2015 Alexander Scott. All rights reserved.
//

import Foundation

public class Calculator {
    
    enum OperationType {
        case Addition
        case Subtraction
        case Multiplication
        case Division
    }
    
    //Current calculator value
    private var currentValue: Double = 0.0
    
    //Current calculator method of operation
    private var methodOfOperation: OperationType = OperationType.Addition
    
    /**
    Calculator Construction/Initialiser
    */
    init(){
        self.reset()
    }
    
    func setOperationType(operationType : OperationType){
        methodOfOperation = operationType
    }
    func operationType() -> OperationType{
        return methodOfOperation
    }
    
    func reset(){
        currentValue = 0.0
        methodOfOperation = OperationType.Addition
    }
    
    func value() -> Double{
        return currentValue;
    }
    
    func setValue(value:Double){
        currentValue = value;
    }
    
    func applyOperand(operand:Double){
        switch self.methodOfOperation{
        case .Addition:
            self.currentValue = Calculator.Addition(self.currentValue, b: operand)
            break
        case .Division:
            self.currentValue = Calculator.Division(self.currentValue, b: operand)
            break
        case .Multiplication:
            self.currentValue = Calculator.Multiplication(self.currentValue, b: operand)
            break
        case .Subtraction:
            self.currentValue = Calculator.Subtract(self.currentValue, b: operand)
            break
        }
    }
    
    // MARK: Static Class Methods of Calculator
    
    /**
    Subtracts operand b from operand a
    
    @param a Primary operator
    @param b Secondary operator
    
    @return Calculation result
    */
    class func Subtract(a:Double, b:Double) -> Double{
        return a - b
    }
    
    /**
    Adds operand b to operand a
    
    @param a Primary operator
    @param b Secondary operator
    
    @return Calculation result
    */
    class func Addition(a:Double, b:Double) -> Double{
        return a + b
    }
    
    /**
    Multiplies operand a with operand b
    
    @param a Primary operator
    @param b Secondary operator
    
    @return Calculation result
    */
    class func Multiplication(a:Double, b:Double)->Double{
        return a * b
    }
    
    /**
    Divides operand a with operand b
    Note: Does not check for d
    
    @param a Primary operator
    @param b Secondary operator
    
    @return Calculation result
    */
    class func Division(a: Double, b:Double)->Double{
        //enforced divide by zero fix
        if (b == 0.0 || a == 0.0){
            return 0.0
        }
        return a/b
    }
    
}