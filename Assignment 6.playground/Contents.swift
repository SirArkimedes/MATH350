/***********************************************************/
// Andrew Robinson                                         //
// Introduction to Numerical Analysis - MATH 350           //
// Easier to view: https://github.com/SirArkimedes/MATH350 //
/***********************************************************/

import Foundation

///////////////////////////////////////////////////
// Solution structures                           //
///////////////////////////////////////////////////

struct Interval {
    var a: Double
    var b: Double
}

func f(_ x: Double) -> Double {
    return (pow(x, 2) + x + 1) * cos(x)
}

func trapezoidal(m: Int, interval: Interval) -> Double {
    let h = (interval.b - interval.a) / Double(m)

    var sum = 0.0
    for k in 1...(m - 1) {
        let xk = interval.a + Double(k) * h
        sum += f(xk)
    }

    return (h / 2) * (f(interval.a) + f(interval.b)) + h * sum
}

func simpsons(m: Int, interval: Interval) -> Double {
    let h = (interval.b - interval.a) / Double(2 * m)

    var leftSum = 0.0
    var rightSum = 0.0

    for k in 1...(m - 1) {
        let xk = interval.a + Double(2 * k) * h
        leftSum += f(xk)
    }

    for k in 1...m {
        let xk = interval.a + Double(2 * k - 1) * h
        rightSum += f(xk)
    }

    return (h / 3) * (f(interval.a) + f(interval.b)) + (2 * h / 3) * leftSum + (4 * h / 3) * rightSum
}

///////////////////////////////////////////////////
// Running and printing the above methods        //
///////////////////////////////////////////////////

let interval = Interval(a: 0, b: Double.pi / 2)
let paddingLength = 11
let separator = "||——————||—————————————|—————————————||—————————————|—————————————||"

print(separator)
print("||  M   ||    T(f,h)   |    S(f,h)   ||  Abs Error  |  Abs Error  ||")
print("||      ||             |             ||  of T(f,h)  |  of S(f,h)  ||")
print(separator)

for i in 1...5 {
    let m = Int(pow(2.0, Double(i)))
    let t = trapezoidal(m: m, interval: interval)
    let s = simpsons(m: m, interval: interval)

    let mString = "\(m)".padding(toLength: 2, withPad: " ", startingAt: 0)
    let tString = String(format: "%.9f", t)
    let sString = String(format: "%.9f", s)

    let bestIntegral = 2.0381974270672
    let absErrorS = bestIntegral - s

    let absErrorTString = String(format: "%.9f", (bestIntegral - t).magnitude)
    let absErrorSString = String(format: "%.9f", (bestIntegral - s).magnitude)

    print("||  \(mString)  || \(tString) | \(sString) || \(absErrorTString) | \(absErrorSString) ||")
}
print(separator)
