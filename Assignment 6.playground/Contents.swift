//*********************************************************//
// Andrew Robinson                                         //
// Introduction to Numerical Analysis - MATH 350           //
// Easier to view: https://github.com/SirArkimedes/MATH350 //
//*********************************************************//

import Foundation

///////////////////////////////////////////////////
// Solution structures                           //
///////////////////////////////////////////////////

// Use this to handle the interval being passed around.
struct Interval {
    var a: Double
    var b: Double
}

func f(_ x: Double) -> Double {
    return (pow(x, 2) + x + 1) * cos(x)
}

// Composite trapezoidal approximation function.
func trapezoidal(m: Int, interval: Interval) -> Double {
    let h = (interval.b - interval.a) / Double(m)

    var sum = 0.0
    for k in 1...(m - 1) {
        let xk = interval.a + Double(k) * h
        sum += f(xk)
    }

    return (h / 2) * (f(interval.a) + f(interval.b)) + h * sum
}

// Composite Simpson's approximation function.
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
    let absErrorTString = String(format: "%.9f", (bestIntegral - t).magnitude)
    let absErrorSString = String(format: "%.9f", (bestIntegral - s).magnitude)

    print("||  \(mString)  || \(tString) | \(sString) || \(absErrorTString) | \(absErrorSString) ||")
}
print(separator)

/* Output:
 ||——————||—————————————|—————————————||—————————————|—————————————||
 ||  M   ||    T(f,h)   |    S(f,h)   ||  Abs Error  |  Abs Error  ||
 ||      ||             |             ||  of T(f,h)  |  of S(f,h)  ||
 ||——————||—————————————|—————————————||—————————————|—————————————||
 ||  2   || 1.726812657 | 2.038441336 || 0.311384770 | 0.000243909 ||
 ||  4   || 1.960534167 | 2.038213875 || 0.077663261 | 0.000016448 ||
 ||  8   || 2.018793948 | 2.038198473 || 0.019403479 | 0.000001046 ||
 ||  16  || 2.033347342 | 2.038197493 || 0.004850085 | 0.000000066 ||
 ||  32  || 2.036984955 | 2.038197431 || 0.001212472 | 0.000000004 ||
 ||——————||—————————————|—————————————||—————————————|—————————————||
 */
