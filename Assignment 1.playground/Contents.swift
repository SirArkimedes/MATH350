import Foundation

let lowerBound = 2.0
let upperBound = 10.0

let n = Int((5 * log((upperBound - lowerBound) * 10)) / log(2)) + 1

// Find mid point of two values.
func midPoint(of left: Double, and right: Double) -> Double {
    return (left + right) / 2
}

// Plug in an x value in to the function given, to get f(x).
func valueFromFunction(of x: Double) -> Double {
    return ((x - 2) * (x - 2)) - naturalLog(of: x)
}

// Compute the natural log.
func naturalLog(of x: Double) -> Double {
    return log(x) / log(exp(1))
}

func run(leftPoint: Double, leftValue: Double, rightPoint: Double, rightValue: Double, iterations: Int) {
    // Calculate mid point and its value.
    let mid = midPoint(of: leftPoint, and: rightPoint)
    let midValue = valueFromFunction(of: mid)
    print("Relative Error: \((rightPoint - leftPoint) / leftPoint), interation: \(iterations)")

    // Check to see if we have a f(x) = 0 OR if our iterations run over the max amount of iterations.
    if leftValue == 0 {
        print()
        print("Left bound is a root: \(leftPoint)")
        print("Left point value: \(leftValue)")
    } else if rightValue == 0 {
        print()
        print("Right bound is a root: \(rightPoint)")
        print("Right point value: \(rightValue)")
    } else if midValue == 0 || iterations >= n {
        print()
        print("Last point computed: \(mid)")
        print("Last point value: \(midValue)")
    } else {
        // Split the intervals in to more than one cycle if we have both positive/negative signs.
        if (leftValue > 0 && rightValue > 0) || (leftValue < 0 && rightValue < 0) {
            run(leftPoint: leftPoint, leftValue: leftValue, rightPoint: mid, rightValue: midValue, iterations: iterations + 1)
            run(leftPoint: mid, leftValue: midValue, rightPoint: rightPoint, rightValue: rightValue, iterations: iterations + 1)
            return
        }

        // The point is on the left side of this new interval.
        if (leftValue > 0 && rightValue < 0 && midValue < 0) || (leftValue < 0 && rightValue > 0 && midValue > 0) {
            run(leftPoint: leftPoint, leftValue: leftValue, rightPoint: mid, rightValue: midValue, iterations: iterations + 1)

        // The point is on the right side of this new interval.
        } else if (leftValue > 0 && rightValue < 0 && midValue > 0) || (leftValue < 0 && rightValue > 0 && midValue < 0) {
            run(leftPoint: mid, leftValue: midValue, rightPoint: rightPoint, rightValue: rightValue, iterations: iterations + 1)
        }
    }
}

// Kick off the recursive process.
run(leftPoint: lowerBound, leftValue: valueFromFunction(of: lowerBound), rightPoint: upperBound, rightValue: valueFromFunction(of: upperBound), iterations: 1)
