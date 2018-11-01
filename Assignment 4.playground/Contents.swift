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

// Find Lagrange's polynomial and return it in string form.
func lagrange() -> String {
    // Finds the top part of the Lagrange multiple.
    func topOfMultiplier(for position: Int) -> String {
        var top = ""

        for (i, point) in points.enumerated() {
            if i != position {
                top += "(x - \(point.x))"
            }
        }
        return top
    }

    // Finds the bottom part of the Lagrange multiple.
    // This returns a Double since they can be easily calculated.
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
        if i == points.count - 1 { // Remove the plus at the end if this is the last point.
            value += "(\(point.y)) [\(topOfMultiplier(for: i)) / \(bottomOfMultiplier(for: i))]"
        } else {
            value += "(\(point.y)) [\(topOfMultiplier(for: i)) / \(bottomOfMultiplier(for: i))] + "
        }
    }

    return value
}

// Find Newton's polynomial of degree that is passed and return it in string form.
func newton(of degree: Int) -> String {
    // Recursive Divided Difference formula.
    // This will reconstruct the table values every time it is called, since it is recursive.
    // The values paramenter is an array of indexes that correspond to the `points` array.
    func dividedDifference(for values: [Int]) -> Double {
        if values.count == 1 {
            return points[values[0]].y
        } else {
            // Clone the values array to then get the "left" and "right" values.
            var valuesRight = Array(values)
            var valuesLeft = Array(values)
            valuesRight.removeFirst()
            valuesLeft.removeLast()

            // Use recursion to do the calcuation.
            return (dividedDifference(for: valuesRight) - dividedDifference(for: valuesLeft)) / (points[values.last!].x - points[values.first!].x)
        }
    }

    if degree == 1 {
        return "\(points[0].y) + \(dividedDifference(for: [0, 1]))(x - \(points[0].x))"
    } else {
        // This is building the (x - xo)'s in the formula.
        var multiple = ""
        for i in 0...degree - 1 {
            multiple += "(x - \(points[i].x))"
        }

        // These correspond the to the points in the `points` array.
        var ddValues = [Int]()
        for i in 0...degree {
            ddValues.append(i)
        }

        // Once again, use recursion to build the formula.
        return "\(newton(of: degree - 1)) + \(dividedDifference(for: ddValues))\(multiple)"
    }
}

print("Lagrange's polynomial:")
print("P4(x) = " + lagrange())
print()
print("Newton's polynomial:")
print("P4(x) = " + newton(of: 4))

/* Output:
 Lagrange's polynomial:
 P4(x) = (-6.0) [(x - 0.1)(x - 0.3)(x - 0.6)(x - 1.0) / 0.018] +
         (-5.89483) [(x - 0.0)(x - 0.3)(x - 0.6)(x - 1.0) / -0.009000000000000001] +
         (-5.65014) [(x - 0.0)(x - 0.1)(x - 0.6)(x - 1.0) / 0.012599999999999997] +
         (-5.17788) [(x - 0.0)(x - 0.1)(x - 0.3)(x - 1.0) / -0.036] +
         (-4.28172) [(x - 0.0)(x - 0.1)(x - 0.3)(x - 0.6) / 0.252]

 Newton's polynomial:
 P4(x) = -6.0 + 1.051700000000002(x - 0.0) +
                0.5724999999999832(x - 0.0)(x - 0.1) +
                0.21500000000004166(x - 0.0)(x - 0.1)(x - 0.3) +
                0.06301587301582073(x - 0.0)(x - 0.1)(x - 0.3)(x - 0.6)
*/
