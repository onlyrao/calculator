//
//  CalculatorBrain.swift
//  calculator
//
//  Created by RAOMACBOOK on 3/31/15.
//  Copyright (c) 2015 Xtoid LLC. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    private var opStack = [Op]()
    
// var knownOps = Dictionary<String, Op>()
    private var knownOps = [String:Op]()
    
    init() {
        knownOps["✖️"] = Op.BinaryOperation("✖️", *)
    //    knownOps["✖️"] = Op.BinaryOperation("✖️") { $0 * $1 }
        knownOps["➗"] = Op.BinaryOperation("➗") { $1 / $0 }
        knownOps["➕"] = Op.BinaryOperation("➕", +)
   //     knownOps["➕"] = Op.BinaryOperation("➕") { $0 + $1 }
        knownOps["➖"] = Op.BinaryOperation("➖") { $1 - $0 }
        knownOps["✔️"] = Op.UnaryOperation("✔️", sqrt)
   //     knownOps["✔️"] = Op.UnaryOperation("✔️") { sqrt($0) }
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
        //using tuples (twople ?) for return values for recurrsion on stack
    {
        if !ops.isEmpty {
            var remainingOps = ops // mutable  ops error is iminent
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remiander) = evaluate(opStack)
        // or use let (result, _) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}