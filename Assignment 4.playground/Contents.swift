/*************************************************/
// Andrew Robinson                               //
// Introduction to Numerical Analysis - MATH 350 //
/*************************************************/

import Foundation

struct Point {
    let x: Double
    let y: Double
}

let points = [Point(x: 0.0, y: -6.0),
              Point(x: 0.1, y: -5.89483),
              Point(x: 0.3, y: -5.65014),
              Point(x: 0.6, y: -5.17788),
              Point(x: 1.0, y: -4.28172)]

// Extend double to handle rounding.
extension Double {
    func round(toPlaces: Int) -> Double {
        return (self * pow(10.0, Double(toPlaces))).rounded() / pow(10.0, Double(toPlaces))
    }
}


func lagrange() {
    func topOfMultiplier(for position: Int) -> String {
        var top = ""

        for (i, point) in points.enumerated() {
            if i != position {
                top += "(x - \(point.x))"
            }
        }
        return top
    }
    func bottomOfMultiplier(for position: Int) -> String {
        var bottom = ""
        let pointAtPosition = points[position]

        for (i, point) in points.enumerated() {
            if i != position {
                bottom += "(\(pointAtPosition.x) - \(point.x))"
            }
        }
        return bottom
    }

    // Top
    for i in 0...points.count - 1 {
        if i == 0 {
            print("          ", terminator: "")
        } else {
            print("             ", terminator: "")
        }
        print(topOfMultiplier(for: i).padding(toLength: bottomOfMultiplier(for: i).count, withPad: " ", startingAt: 0), terminator: "")
    }
    print()

    // Middle
    for (i, point) in points.enumerated() {
        let multiplier = String(format: "%.6f ", point.y)
        print(multiplier, terminator: "")
        for _ in 1...bottomOfMultiplier(for: i).count {
            print("-", terminator: "")
        }

        if i != points.count - 1 {
            print(" + ", terminator: "")
        }
    }
    print()

    // Top
    for i in 0...points.count - 1 {
        if i == 0 {
            print("          ", terminator: "")
        } else {
            print("             ", terminator: "")
        }
        print(bottomOfMultiplier(for: i), terminator: "")
    }
    print()
}

func newton(of degree: Int) -> String {
    func dividedDifference(for values: [Int]) -> Double {
        if values.count == 1 {
            return points[values[0]].y
        } else {
            var valuesRight = Array(values)
            var valuesLeft = Array(values)
            valuesRight.removeFirst()
            valuesLeft.removeLast()

            return (dividedDifference(for: valuesRight) - dividedDifference(for: valuesLeft)) / (points[values.last!].x - points[values.first!].x)
        }
    }

    if degree - 1 == 1 {
        return "\(points[0].y) + \(dividedDifference(for: [0, 1]))(x - \(points[0].x))"
    } else {
        var multiple = ""
        for i in 0...degree - 1 {
            multiple += "(x - \(points[i].x))"
        }

        var ddValues = [Int]()
        for i in 0...degree {
            ddValues.append(i)
        }

        return "\(newton(of: degree - 1)) + \(dividedDifference(for: ddValues))\(multiple)"
    }
}

print("Lagrange's polynomial:")
print("P4(x) =")
lagrange()
print()
print("Newton's polynomial:")
print("P4(x) = " + newton(of: 4))
