/*************************************************/
// Andrew Robinson                               //
// Introduction to Numerical Analysis - MATH 350 //
/*************************************************/

import Foundation


// Create a "to the power" operator.
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

// Extend double to handle rounding.
extension Double {
    func round(toDecimalPlaces: Int) -> Double {
        return (self * Double(10 ^^ toDecimalPlaces)).rounded() / Double(10 ^^ toDecimalPlaces)
    }
}

// Plug in an x value in to the function given, to get f(x).
func valueFromFunction(of x: Double) -> Double {
    return sin(x) + x * x * cos(x) - x * x - x
}

// Plug in an x value in to the function's derivative, to get f'(x).
func valueFromDerivative(of x: Double) -> Double {
    return x * x * -sin(x) - 2 * x + 2 * x * cos(x) + cos(x) - 1
}

func valueFromIterationFormula(of x: Double) -> Double {
    return x - (valueFromFunction(of: x) / valueFromDerivative(of: x))
}

var lastXValue = 0.0
func run(for xi: Double) {
    print(xi)
    if lastXValue.round(toDecimalPlaces: 6) == xi.round(toDecimalPlaces: 6) {
        print("Done!")
        print(lastXValue)
        print(xi)
        return
    } else {
        lastXValue = valueFromIterationFormula(of: xi)
        run(for: lastXValue)
    }
}

run(for: valueFromIterationFormula(of: 1.0)) // x0 = 1
