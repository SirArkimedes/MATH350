/*************************************************/
// Andrew Robinson                               //
// Introduction to Numerical Analysis - MATH 350 //
/*************************************************/

import Foundation

struct Point {
    let x: Double
    let y: Double
}

let points = [Point(x: 0, y: 2),
              Point(x: 1, y: 5.4375),
              Point(x: 2.5, y: 7.3516),
              Point(x: 3, y: 7.5625),
              Point(x: 4.5, y: 8.4453),
              Point(x: 5, y: 9.1875),
              Point(x: 6, y: 12)]

func lagrangeApproximate(x: Double) -> Double {
    func generateMultiplier(for position: Int) -> Double {
        var top = 1.0
        var bottom = 1.0
        let pointAtPosition = points[position]

        for (i, point) in points.enumerated() {
            if i != position {
                top *= x - point.x
                bottom *= pointAtPosition.x - point.x
            }
        }
        return top / bottom
    }

    var value = 0.0
    for (i, point) in points.enumerated() {
        value += generateMultiplier(for: i) * point.y
    }
    return value
}

lagrangeApproximate(x: 2)
