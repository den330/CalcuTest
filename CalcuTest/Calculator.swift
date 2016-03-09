//
//  Calculator.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-29.
//  Copyright © 2016 Yaxin Yuan. All rights reserved.
//

import Foundation

class Calculator{
    
    var text: String

    
    init(text:String){
        self.text = text
    }
    
    func calCu(num1: Int, num2: Int) -> Int{
        var result = 0
        switch text{
        case "+": result = num1 + num2
        case "-":  result = num1 - num2
        case "*": result = num1 * num2
        case "/": result = num1 / num2
        default: break
        }
        return result
    }

}
