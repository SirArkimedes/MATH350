/*************************************************/
// Andrew Robinson                               //
// Introduction to Numerical Analysis - MATH 350 //
/*************************************************/

import Foundation

// P(x)
func evaluteP(x: Double, coefficients: [Double]) -> Double {
    var value = 0.0
    for (i, coefficient) in coefficients.enumerated() {
        let toThePower = Double(coefficients.count - 1) - Double(i)
        value += coefficient * pow(x, toThePower)
    }
    return value
}

// P'(x)
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

// Integral of P(x) over left and right interval.
func integral(left: Double, right: Double, coefficients: [Double]) -> Double {
    // Define a function that can be used twice to calculate the integral, given x.
    // Using the above-passed coefficients.
    func integrate(x: Double) -> Double {
        var value = 0.0
        for (i, coefficient) in coefficients.enumerated() {
            let toThePower = Double(coefficients.count - 1) - Double(i)
            value += (coefficient * pow(x, toThePower + 1)) / (toThePower + 1)
        }
        return value
    }

    // Uses the locally defined fumction.
    return integrate(x: left) - integrate(x: right)
}

let problemOne = [-0.02, 0.1, -0.2, 1.66]
let problemTwo = [-0.04, 0.14, -0.16, 2.08]

print("Problen #1:")
print("a. P(4) =                         \(evaluteP(x: 4.0, coefficients: problemOne))")
print("b. P'(4) =                        \(evaluatePPrime(x: 4.0, coefficients: problemOne))")
print("c. Integral of P(x) over [1, 4] = \(integral(left: 1.0, right: 4.0, coefficients: problemOne))")
print("d. P(5.5) =                       \(evaluteP(x: 5.5, coefficients: problemOne))")
print()

print("Problen #2:")
print("a. P(3) =                         \(evaluteP(x: 3.0, coefficients: problemTwo))")
print("b. P'(3) =                        \(evaluatePPrime(x: 3.0, coefficients: problemTwo))")
print("c. Integral of P(x) over [0, 3] = \(integral(left: 0, right: 3, coefficients: problemTwo))")
print("d. P(4.5) =                       \(evaluteP(x: 4.5, coefficients: problemTwo))")
print()
