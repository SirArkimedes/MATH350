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


func lagrange() -> String {
    func topOfMultiplier(for position: Int) -> String {
        var top = ""

        for (i, point) in points.enumerated() {
            if i != position {
                top += "(x - \(point.x))"
            }
        }
        return top
    }
    func bottomOfMultiplier(for position: Int) -> Double {
        var bottom = 1.0
        let pointAtPosition = points[position]

        for (i, point) in points.enumerated() {
            if i != position {
                bottom *= pointAtPosition.x - point.x
            }
        }
        return bottom
    }

    var value = ""
    for (i, point) in points.enumerated() {
        if i == points.count - 1 {
            value += "(\(point.y)) [\(topOfMultiplier(for: i)) / \(bottomOfMultiplier(for: i))]"
        } else {
            value += "(\(point.y)) [\(topOfMultiplier(for: i)) / \(bottomOfMultiplier(for: i))] + "
        }
    }

    return value
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

    if degree == 1 {
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
print("P4(x) = " + lagrange())
print()
print("Newton's polynomial:")
print("P4(x) = " + newton(of: 4))
