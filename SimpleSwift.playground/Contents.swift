print("Welcome to the UW Calculator Playground")
import AppKit

func factorial(_ val: Int) -> Int {
    print("factorial reached")
    var result = 1
    if val > 0 {
        for i in 0...(val - 1) {
            result = result * (val - i)
        }
    }
    
    return result
}

func average (_ args: [String]) -> Double {
    var sum = 0.0
    let count = Double(args.count - 1)
    for i in 0...args.count - 2 {
        sum = sum + Double(args[i])!
    }
    return Double(sum / count)
}

func count (_ args: [String]) -> Int {
    var sum = 0
    for i in 0...args.count - 2 {
        sum = sum + Int(args[i])!
    }
    return sum
}

func mod(_ args: String) -> Int {
//    separate string
// find where the mod is located
// take the value before mod and divide by value after mod
//    subtract the result from the larger value
// if value is less than or - to 1, return 0
    let comps = args.components(separatedBy: " ")
    var numer = Int()
    var denom = Int()
    var timesDiv = Int()
    
    for i in 0...comps.count - 1 {

        if comps[i] == "%" {
            numer = Int(comps[i - 1])!
            denom = Int(comps[i + 1])!
            timesDiv = numer / denom
            if timesDiv == 0 {
                return 0
            }
        }
    }
    let result = numer - (timesDiv * denom)
    return result
}

func calculate(_ args: [String]) -> Int {
    var expression = String()
    if args.count == 1 {
        return Int(args[0]) ?? 0
    }
    
    for i in 0...args.count - 2 {
        expression = expression + args[i] + " "
    }
    expression = expression + args[args.count - 1]
    print("formatted expression: " + expression)
    return calculate(expression)
}

func calculate(_ args: String) -> Int {
    let parts = args.components(separatedBy: " ")
    
    // If there is more than one word in the expression, check to see if the last part is a string. If not, use the operator expression from above

    if parts.count > 1 {
        let lastVal = parts[parts.count - 1]

        if lastVal == "fact" {
            // factorial
            let num = Int(parts[0])!
            print(factorial(num))
            return factorial(num)
        } else if lastVal == "avg" {
            print("is avg")
            print(average(parts))
            return Int(average(parts))
        } else if lastVal == "count" {
            print("is count")
            print(count(parts))
            return Int(parts[parts.count - 2])!
        } else {
            if args.contains("%") {
                print("use mod operator")
                return(mod(args))
            }
            
            print("is not a string")
            let expn = NSExpression(format:args)
            print("\(expn.expressionValue(with: nil, context: nil) ?? 0)")
            let returnVal = (expn.expressionValue(with: nil, context: nil) ?? 0) as? Int
            return returnVal!
        }
    }
    return 0
}// -------------------------------------------
// All of these expressions should return true
// if you have implemented calculate() correctly
//
calculate(["2", "+", "2"]) == 4
calculate(["4", "+", "4"]) == 8
calculate(["2", "-", "2"]) == 0
calculate(["2", "*", "2"]) == 4
calculate(["2", "/", "2"]) == 1
calculate(["2", "%", "2"]) == 0

calculate(["1", "2", "3", "count"]) == 3
calculate(["1", "2", "3", "4", "5", "count"]) == 5
calculate(["count"]) == 0

calculate(["1", "2", "3", "4", "5", "avg"]) == 3
    // 15 / 5 = 3
calculate(["2", "2", "4", "4", "avg"]) == 3
    // 12 / 4 = 3
calculate(["2", "avg"]) == 2
    // 2 / 1 = 2
calculate(["avg"]) == 0
    // 0 / 0 = 0 (not really, but it's an edge case

calculate(["0", "fact"]) == 1
calculate(["1", "fact"]) == 1
calculate(["2", "fact"]) == 2 // 2*1
calculate(["5", "fact"]) == 120 // 5*4*3*2*1
calculate(["fact"]) == 0

calculate("2 + 2") == 4
calculate("2 * 2") == 4
calculate("2 - 2") == 0
calculate("2 / 2") == 1

calculate("1 2 3 4 5 count") == 5
calculate("1 2 3 4 5 avg") == 3
calculate("5 fact") == 120

// -------------------------------------------
// These are extra credit tests; commented out
// uncomment them to turn them on for evaluation

// Implement calculate([String]) and calculate(String)
// to handle negative numbers
/*
calculate(["2", "+", "-2"]) == 0
calculate(["2", "-", "-2"]) == 4
calculate(["2", "*", "-2"]) == -4
calculate(["2", "/", "-2"]) == -1
calculate(["-5", "%", "2"]) == -1

calculate(["1", "-2", "3", "-2", "5", "avg"]) == 1

calculate("2 + -2") == 0
calculate("2 * -2") == -4
calculate("2 - -2") == 4
calculate("-2 / 2") == -1

calculate("1 -2 3 -4 5 count") == 5
*/
 
// Implement calculate([String]) and calculate(String)
// to use floating-point values
/*
func calculate(_ args: [String]) -> Double {
    return -1.0
}
func calculate(_ arg: String) -> Double {
    return -1.0
}

calculate(["2.0", "+", "2.0"]) == 4.0
calculate([".5", "+", "1.5"]) == 2.0
calculate(["12.0", "-", "12.0"]) == 0.0
calculate(["2.5", "*", "2.5"]) == 6.25
calculate(["2.0", "/", "2.0"]) == 1.0
calculate(["2.0", "%", "2.0"]) == 0.0
calculate("1.0 2.0 3.0 4.0 5.0 count") == 5
*/
