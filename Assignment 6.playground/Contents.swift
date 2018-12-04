/***********************************************************/
// Andrew Robinson                                         //
// Introduction to Numerical Analysis - MATH 350           //
// Easier to view: https://github.com/SirArkimedes/MATH350 //
/***********************************************************/

import Foundation

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

    for k in 1...(m - 1) {
        let xk = interval.a + Double(2 * k - 1) * h
        rightSum += f(xk)
    }

    return (h / 3) * (f(interval.a) + f(interval.b)) + (2 * h / 3) * leftSum + (4 * h / 3) * leftSum
}

let interval = Interval(a: 0, b: Double.pi / 2)
print(trapezoidal(m: 2, interval: interval))
print(trapezoidal(m: 4, interval: interval))
print(trapezoidal(m: 8, interval: interval))
print(trapezoidal(m: 32, interval: interval))

print()

print(simpsons(m: 2, interval: interval))
print(simpsons(m: 32, interval: interval))
print(simpsons(m: 128, interval: interval))
