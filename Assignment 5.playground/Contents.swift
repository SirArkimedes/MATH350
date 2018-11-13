/*************************************************/
// Andrew Robinson                               //
// Introduction to Numerical Analysis - MATH 350 //
/*************************************************/

import Foundation

func h(_ k: Double) -> Double {
    return pow(10.0, -k)
}

func f(x: Double) -> Double {
    return sin(pow(x, 3) - 7 * pow(x, 2) + 6 * x + 8)
}

let xo = (1.0 - sqrt(5)) / 3.0

func formulaTwo(_ k: Double) -> Double {
    return (f(x: xo + h(k)) - f(x: xo)) / h(k)
}

func formulaThree(_ k: Double) -> Double {
    return (f(x: xo + h(k)) - f(x: xo - h(k))) / (2 * h(k))
}

func formulaTen(_ k: Double) -> Double {
    return (-f(x: xo + 2 * h(k)) + 8 * f(x: xo + h(k)) - 8 * f(x: xo - h(k)) + f(x: xo - 2 * h(k))) / (12 * h(k))
}

var formulaTwoValues = [Double]()
var formulaThreeValues = [Double]()
var formulaTenValues = [Double]()

func run(with formula: ((Double) -> Double), arrayToAppend: inout [Double]) -> Double {
    var previousApproximation = 2.0
    var currentApproximation = 0.0
    var nextApproximation = 1.0
    
    var k = 1.0
    while (nextApproximation - currentApproximation).magnitude < (currentApproximation - previousApproximation).magnitude {
        previousApproximation = formula(k)
        currentApproximation = formula(k + 1)
        nextApproximation = formula(k + 2)
        k += 1
        
        arrayToAppend.append(currentApproximation)
    }
    
    return k
}

run(with: formulaTwo(_:), arrayToAppend: &formulaTwoValues)
run(with: formulaThree(_:), arrayToAppend: &formulaThreeValues)
run(with: formulaTen(_:), arrayToAppend: &formulaTenValues)

//String(format: "%.13f", currentApproximation)
//print(previousApproximation)
//print(currentApproximation)
//print(k)
//print(nextApproximation)

//for k in 1...10 {
//    print("Two: \(formulaTwo(Double(k)))")
//    print("Three: \(formulaThree(Double(k)))")
//    print("Ten: \(formulaTen(Double(k)))")
//    print()
//}
