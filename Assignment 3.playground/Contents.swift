/*************************************************/
// Andrew Robinson                               //
// Introduction to Numerical Analysis - MATH 350 //
/*************************************************/

import Foundation

func evaluteP(x: Double, coefficients: [Double]) -> Double {
    var value = 0.0
    for (i, coefficient) in coefficients.enumerated() {
        let toThePower = Double(coefficients.count - 1) - Double(i)
        value += coefficient * pow(x, toThePower)
    }
    return value
}

func evaluatePPrime(x: Double, coefficients: [Double]) -> Double {
    var value = 0.0
    for (i, coefficient) in coefficients.enumerated() {
        let toThePower = Double(coefficients.count - 1) - Double(i)
        if toThePower - 1 >= 0 {
            value += toThePower * coefficient * pow(x, toThePower - 1)
        }
    }
    return value
}

func integral(left: Double, right: Double, coefficients: [Double]) -> Double {
    func integrate(x: Double) -> Double {
        var value = 0.0
        for (i, coefficient) in coefficients.enumerated() {
            let toThePower = Double(coefficients.count - 1) - Double(i)
            value += (coefficient * pow(x, toThePower + 1)) / (toThePower + 1)
        }
        return value
    }

    return integrate(x: left) - integrate(x: right)
}

let problemOne = [-0.02, 0.1, -0.2, 1.66]
let problemTwo = [-0.04, 0.14, -0.16, 2.08]

evaluteP(x: 4.0, coefficients: problemOne)
evaluatePPrime(x: 4.0, coefficients: problemOne)
integral(left: 1.0, right: 4.0, coefficients: problemOne)
evaluteP(x: 5.5, coefficients: problemOne)

evaluteP(x: 3.0, coefficients: problemTwo)
evaluatePPrime(x: 3.0, coefficients: problemTwo)
integral(left: 0, right: 3, coefficients: problemTwo)
evaluteP(x: 4.5, coefficients: problemTwo)
