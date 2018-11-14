/*************************************************/
// Andrew Robinson                               //
// Introduction to Numerical Analysis - MATH 350 //
/*************************************************/

import Foundation

///////////////////////////////////////////////////
// Helpers that don't have to deal with solution //
///////////////////////////////////////////////////

// Extend string to do left padding.
extension String { // Retrieved from: https://stackoverflow.com/a/39215372/4447090
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}

///////////////////////////////////////////////////
// Solution methods                              //
///////////////////////////////////////////////////

func h(_ k: Double) -> Double {
    return pow(10.0, -k)
}

func f(x: Double) -> Double {
    return sin(pow(x, 3) - 7 * pow(x, 2) + 6 * x + 8)
}

func derivateOfF(x: Double) -> Double {
    return cos(pow(x, 3) - 7 * pow(x, 2) + 6 * x + 8) * (3 * pow(x, 2) - 14 * x + 6)
}

let xo = (1.0 - sqrt(5.0)) / 3.0

func formulaTwo(_ k: Double) -> Double {
    return (f(x: xo + h(k)) - f(x: xo)) / h(k)
}

func formulaThree(_ k: Double) -> Double {
    return (f(x: xo + h(k)) - f(x: xo - h(k))) / (2 * h(k))
}

func formulaTen(_ k: Double) -> Double {
    return (-f(x: xo + 2 * h(k)) + 8 * f(x: xo + h(k)) - 8 * f(x: xo - h(k)) + f(x: xo - 2 * h(k))) / (12 * h(k))
}

func run(with formula: ((Double) -> Double)) -> Double {
    var previousApproximation = 2.0
    var currentApproximation = 0.0
    var nextApproximation = 1.0
    
    var k = 0.0
    while (nextApproximation - currentApproximation).magnitude < (currentApproximation - previousApproximation).magnitude {
        k += 1
        previousApproximation = formula(k)
        currentApproximation = formula(k + 1)
        nextApproximation = formula(k + 2)


        print((nextApproximation - currentApproximation).magnitude)
        print((currentApproximation - previousApproximation).magnitude)
        print((nextApproximation - currentApproximation).magnitude < (currentApproximation - previousApproximation).magnitude)
    }
    
    return k
}

///////////////////////////////////////////////////
// Running and printing the above methods        //
///////////////////////////////////////////////////

let formulaTwoK = run(with: formulaTwo(_:))
let formulaThreeK = run(with: formulaThree(_:))
let formulaTenK = run(with: formulaTen(_:))


// Printing... output.

let separator = "|————————||——————————————————|——————————————————||——————————————————|——————————————————||——————————————————|——————————————————||"

print(separator)
print("|  Step  || Approximation by |   Error using    || Approximation by |   Error using    || Approximation by |   Error using    ||")
print("|  Size  ||    formula (2)   |   formula (2)    ||    formula (3)   |   formula (3)    ||   formula (10)   |   formula (10)   ||")
print(separator)

for i in 1...Int(max(formulaTwoK, formulaThreeK, formulaTenK)) + 1 {
    let paddingLength = 16
    let h = "10^-\(i)".padding(toLength: 6, withPad: " ", startingAt: 0)

    let formulaTwoString = String(format: "%.13f", formulaTwo(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")
    let errorTwo = String(format: "%.13f", derivateOfF(x: xo) - formulaTwo(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")

    let formulaThreeString = String(format: "%.13f", formulaThree(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")
    let errorThree = String(format: "%.13f", derivateOfF(x: xo) - formulaThree(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")

    let formulaTenString = String(format: "%.13f", formulaTen(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")
    let errorTen = String(format: "%.13f", derivateOfF(x: xo) - formulaTen(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")

    print("| \(h) || \(formulaTwoString) | \(errorTwo) || \(formulaThreeString) | \(errorThree) || \(formulaTenString) | \(errorTen) ||")
}
print(separator)

print()
print("From (2):  f'(xo) ≈ \(String(format: "%.13f", formulaTwo(formulaTwoK))), where h = 10^-\(Int(formulaTwoK))")
print("From (3):  f'(xo) ≈ \(String(format: "%.13f", formulaThree(formulaThreeK))), where h = 10^-\(Int(formulaThreeK))")
print("From (10): f'(xo) ≈ \(String(format: "%.13f", formulaTen(formulaTenK))), where h = 10^-\(Int(formulaTenK))")
