/*************************************************/
// Andrew Robinson                               //
// Introduction to Numerical Analysis - MATH 350 //
/*************************************************/

import Foundation

// P(x)
func evaluteP(x: Double, coefficients: [Double]) -> Double {
    var b = Array(coefficients)
    for i in 0...coefficients.count - 2 { // Swift, this language, can't go down, only up in iterations.
        let k = coefficients.count - 2 - i
        b[k] = coefficients[k] + b[k + 1] * x
    }

    return b[0]
}

// P'(x)
func evaluatePPrime(x: Double, coefficients: [Double]) -> Double {
    var d = Array(coefficients)
    d[d.count - 2] = Double(d.count - 1) * d[d.count - 1]

    for i in 0...coefficients.count - 3 { // Swift, this language, can't go down, only up in iterations.
        let k = coefficients.count - 2 - i
        d[k - 1] = Double(k) * coefficients[k] + d[k] * x
    }

    return d[0]
}

// Integral of P(x) over left and right interval.
func integral(left: Double, right: Double, coefficients: [Double]) -> Double {
    // Define a function that can be used twice to calculate the integral, given x.
    // Using the above-passed coefficients.
    func integrate(x: Double) -> Double {
        var b = Array(coefficients)
        b.insert(b[b.count - 1] / 4.0, at: b.count) // Insert this since the algorithm uses `N` slots.

        for i in 0...coefficients.count - 1 { // Swift, this language, can't go down, only up in iterations.
            let k = b.count - 2 - i
            if k > 0 {
                b[k] = coefficients[k - 1] / Double(k) + b[k + 1] * x
            } else { // coefficients[0 - 1] is out of bounds, so do this check instead.
                b[k] = b[k + 1] * x
            }
        }

        return b[0]
    }

    // Uses the locally defined fumction.
    return integrate(x: left) - integrate(x: right)
}

// All coefficients require to be in reverse order.
let problemExample: [Double] = [-0.02, 0.2, -0.4, 1.28].reversed()
let problemOne: [Double] = [-0.02, 0.1, -0.2, 1.66].reversed()
let problemTwo: [Double] = [-0.04, 0.14, -0.16, 2.08].reversed()

print("Problen #1:")
print("a. P(4) =                         \(evaluteP(x: 4.0, coefficients: problemOne))")
print("b. P'(4) =                        \(evaluatePPrime(x: 4.0, coefficients: problemOne))")
print("c. Integral of P(x) over [1, 4] = \(integral(left: 4.0, right: 1.0, coefficients: problemOne))")
print("d. P(5.5) =                       \(evaluteP(x: 5.5, coefficients: problemOne))")
print()

print("Problen #2:")
print("a. P(3) =                         \(evaluteP(x: 3.0, coefficients: problemTwo))")
print("b. P'(3) =                        \(evaluatePPrime(x: 3.0, coefficients: problemTwo))")
print("c. Integral of P(x) over [0, 3] = \(integral(left: 3.0, right: 0.0, coefficients: problemTwo))")
print("d. P(4.5) =                       \(evaluteP(x: 4.5, coefficients: problemTwo))")
print()
