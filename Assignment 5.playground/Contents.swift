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

///////////////////////////////////////////////////
// Solution methods                              //
///////////////////////////////////////////////////

func h(_ k: Double) -> Double {
    return pow(10.0, -k)
}

func f(x: Double) -> Double {
    return sin(pow(x, 3) - 7 * pow(x, 2) + 6 * x + 8)
}

func derivateOfF(x: Double) -> Double {
    return cos(pow(x, 3) - 7 * pow(x, 2) + 6 * x + 8) * (3 * pow(x, 2) - 14 * x + 6)
}

let xo = (1.0 - sqrt(5.0)) / 3.0

func formulaTwo(_ k: Double) -> Double {
    return (f(x: xo + h(k)) - f(x: xo)) / h(k)
}

func formulaThree(_ k: Double) -> Double {
    return (f(x: xo + h(k)) - f(x: xo - h(k))) / (2 * h(k))
}

func formulaTen(_ k: Double) -> Double {
    return (-f(x: xo + 2 * h(k)) + 8 * f(x: xo + h(k)) - 8 * f(x: xo - h(k)) + f(x: xo - 2 * h(k))) / (12 * h(k))
}

func run(with formula: ((Double) -> Double)) -> Double {
    var previousApproximation = 2.0
    var currentApproximation = 0.0
    var nextApproximation = 1.0
    
    var k = 1.0
    while (nextApproximation - currentApproximation).magnitude < (currentApproximation - previousApproximation).magnitude {
        previousApproximation = formula(k)
        currentApproximation = formula(k + 1)
        nextApproximation = formula(k + 2)
        k += 1
    }
    
    return k
}

///////////////////////////////////////////////////
// Running and printing the above methods        //
///////////////////////////////////////////////////

let formulaTwoK = run(with: formulaTwo(_:))
let formulaThreeK = run(with: formulaThree(_:))
let formulaTenK = run(with: formulaTen(_:))


// Printing... output.

let separator = "|————————||——————————————————|——————————————————||——————————————————|——————————————————||——————————————————|——————————————————||"

print(separator)
print("|  Step  || Approximation by |   Error using    || Approximation by |   Error using    || Approximation by |   Error using    ||")
print("|  Size  ||    formula (2)   |   formula (2)    ||    formula (3)   |   formula (3)    ||   formula (10)   |   formula (10)   ||")
print(separator)

for i in 1...Int(max(formulaTwoK, formulaThreeK, formulaTenK)) + 1 {
    let paddingLength = 16
    let h = "10^-\(i)".padding(toLength: 6, withPad: " ", startingAt: 0)

    let formulaTwoString = String(format: "%.13f", formulaTwo(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")
    let errorTwo = String(format: "%.13f", derivateOfF(x: xo) - formulaTwo(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")

    let formulaThreeString = String(format: "%.13f", formulaThree(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")
    let errorThree = String(format: "%.13f", derivateOfF(x: xo) - formulaThree(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")

    let formulaTenString = String(format: "%.13f", formulaTen(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")
    let errorTen = String(format: "%.13f", derivateOfF(x: xo) - formulaTen(Double(i))).leftPadding(toLength: paddingLength, withPad: " ")

    print("| \(h) || \(formulaTwoString) | \(errorTwo) || \(formulaThreeString) | \(errorThree) || \(formulaTenString) | \(errorTen) ||")
}
print(separator)

print()
print("From (2):  f'(xo) ≈ \(String(format: "%.13f", formulaTwo(formulaTwoK))), where h = 10^-\(Int(formulaTwoK))")
print("From (3):  f'(xo) ≈ \(String(format: "%.13f", formulaThree(formulaThreeK))), where h = 10^-\(Int(formulaThreeK))")
print("From (10): f'(xo) ≈ \(String(format: "%.13f", formulaTen(formulaTenK))), where h = 10^-\(Int(formulaTenK))")

/* Output:
 |————————||——————————————————|——————————————————||——————————————————|——————————————————||——————————————————|——————————————————||
 |  Step  || Approximation by |   Error using    || Approximation by |   Error using    || Approximation by |   Error using    ||
 |  Size  ||    formula (2)   |   formula (2)    ||    formula (3)   |   formula (3)    ||   formula (10)   |   formula (10)   ||
 |————————||——————————————————|——————————————————||——————————————————|——————————————————||——————————————————|——————————————————||
 | 10^-1  ||  1.4102689808905 | -6.6709756208746 || -4.7231852939287 | -0.5375213460554 || -5.5680910850784 |  0.3073844450943 ||
 | 10^-2  || -4.5414390213222 | -0.7192676186619 || -5.2566545045505 | -0.0040521354337 || -5.2607664030114 |  0.0000597630273 ||
 | 10^-3  || -5.1890378788961 | -0.0716687610880 || -5.2606662672138 | -0.0000403727703 || -5.2607066459940 |  0.0000000060099 ||
 | 10^-4  || -5.2535432905498 | -0.0071633494343 || -5.2607062362703 | -0.0000004037139 || -5.2607066399839 | -0.0000000000002 ||
 | 10^-5  || -5.2599903412887 | -0.0007162986955 || -5.2607066359567 | -0.0000000040275 || -5.2607066399960 |  0.0000000000119 ||
 | 10^-6  || -5.2606350106066 | -0.0000716293776 || -5.2607066400867 |  0.0000000001026 || -5.2607066402070 |  0.0000000002228 ||
 | 10^-7  || -5.2606994760396 | -0.0000071639446 || -5.2607066403088 |  0.0000000003246 || -5.2607066401237 |  0.0000000001396 ||
 | 10^-8  || -5.2607059153331 | -0.0000007246510 || -5.2607066369781 | -0.0000000030061 || -5.2607066416040 |  0.0000000016199 ||
 | 10^-9  || -5.2607066480803 |  0.0000000080962 || -5.2607067591026 |  0.0000001191185 || -5.2607068238656 |  0.0000001838815 ||
 | 10^-10 || -5.2607040945674 | -0.0000025454168 || -5.2607046496789 | -0.0000019903053 || -5.2607040945674 | -0.0000025454168 ||
 |————————||——————————————————|——————————————————||——————————————————|——————————————————||——————————————————|——————————————————||
 
 From (2):  f'(xo) ≈ -5.2607066480803, where h = 10^-9
 From (3):  f'(xo) ≈ -5.2607066403088, where h = 10^-7
 From (10): f'(xo) ≈ -5.2607066399960, where h = 10^-5
 */
