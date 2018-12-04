/***********************************************************/
// Andrew Robinson                                         //
// Introduction to Numerical Analysis - MATH 350           //
// Easier to view: https://github.com/SirArkimedes/MATH350 //
/***********************************************************/

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

///////////////////////////////////////////////////
// Running and printing the above methods        //
///////////////////////////////////////////////////

let interval = Interval(a: 0, b: Double.pi / 2)
let paddingLength = 11
let separator = "||——————||—————————————|—————————————||——————————————————||"

print(separator)
print("||   M  ||    T(f,h)   |    S(f,h)   ||     Abs Error    ||")
print(separator)

for i in 1...5 {
    let m = Int(pow(2.0, Double(i)))
    let t = trapezoidal(m: m, interval: interval)
    let s = simpsons(m: m, interval: interval)

    let mString = "\(m)".leftPadding(toLength: 2, withPad: " ")
    let tString = String(format: "%.9f", t)
    let sString = String(format: "%.9f", s)

    let absError = ""

    print("||  \(mString)  || \(tString) | \(sString) || \(absError) ||")
}
print(separator)
