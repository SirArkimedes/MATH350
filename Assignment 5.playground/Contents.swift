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
for k in 1...10 {
    print("Two: \(formulaTwo(Double(k)))")
    print("Three: \(formulaThree(Double(k)))")
    print("Ten: \(formulaTen(Double(k)))")
    print()
}
