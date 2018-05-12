/** 
 * @Author: Valentin Kirilov 
 * @Date: 2018-03-27 18:11:28 
 * @Desc: Swift Programming Course
 *
 * Homework 1
 * Task 2
 *
 * FMU, Sofia University 
 */

import Foundation

let BRACKETS = ["(", ")"]
let ARITHMETIC = ["+", "-", "*", "/"]
let FUNCTIONS = ["^"]

func evaluate(expression: String) -> Double? {
 	//print(expression)

    let splited: [String]? = splitInput(expression)
    if let isSplited = splited {
        //print("Splited: \(isSplited)")

        let rpn: [String]? = convertToRPN(isSplited)
        if let isRpn = rpn {
            //print("RPN: \(isRpn)")
            let result = calculateWithReversePolishNotation(isRpn)

            return result
        }
        else {
            return nil
        }
    }
    else {
        return nil
    }
}

func splitInput(_ input: String) -> [String]? {
    let trimmed = input.replacingOccurrences(of: " ", with: "")
    var inputCharacters: [Character] = Array(trimmed)
    var splited: [String] = []
    var number: String = ""

    var currentChar: String
    for i in 0..<inputCharacters.count {
        currentChar = String(inputCharacters[i])

        if (currentChar == "-" && (i == 0 || inputCharacters[i-1] == "," || inputCharacters[i-1] == "(")) {
            // We have a negative number on the first poistion
            // print("Starting a negative number: \(currentChar)")
            number += currentChar
        }
        else if (isNumeric(currentChar) || currentChar == ".") {
            // We have a digit or a dot
            // print("Adding a digit to a number: \(currentChar)")
            number += currentChar
        }
        else if (isNumeric(currentChar) == false && currentChar != "." && number.count > 0) {
            // print('Finishing a number: \(number)')
            splited.append(number)
            number = ""
        }
        
        if (number.count == 0) {
            // Check for brackets
            if (BRACKETS.contains(currentChar) == true) {
                //print('Pushing a bracket: \(currentChar)')
                splited.append(currentChar)
            }
            // Check for arithmetic operators 
            else if (ARITHMETIC.contains(currentChar) == true || FUNCTIONS.contains(currentChar) == true) {
                //print('Pushing an arithmetic: \(currentChar)')
                splited.append(currentChar)
            }
            else if (currentChar == ",") {
                //print('Pushing a separator: \(currentChar)')
                splited.append(currentChar)
            }
            else {          
                //print("Invalid expression")
                return nil
            }
        }
    }

    if (number.count > 0) {
        splited.append(number)
    }

    return splited
}

func convertToRPN(_ input: [String]) -> [String]? {
    var stack: [String] = []
    var queue: [String] = []

    for token in input {
        //print(token)

        if (isNumeric(token)) {
            queue.append(token)
        }
        else if (FUNCTIONS.contains(token) == true) {
            stack.append(token)
        }
        else if (token == ",") {
            if (stack.contains("(") == false || stack.count == 0) {
                //print("Invalid function separator")
                return nil
            }

            while(stackTop(stack) != "(") {
                let lastToken = stack.popLast()
                queue.append(lastToken!)
            }
        }
        else if (ARITHMETIC.contains(token) == true) {
            while(stack.count > 0 && ARITHMETIC.contains(stackTop(stack)) == true && checkPrecedence(token) <= checkPrecedence(stackTop(stack))) {
                let lastToken = stack.popLast()
                queue.append(lastToken!)
            }

            stack.append(token)
        }
        else if (token == "(") {
            stack.append(token)
        }
        else if (token == ")") {
            if (stack.contains("(") == false || stack.count == 0) {
                //print("Stack has no (")
                return nil
            }        

            while(stack.count > 0 && stackTop(stack) != "(") {
                let lastToken = stack.popLast()
                queue.append(lastToken!)
            }            
            stack.removeLast()

            // if (FUNCTIONS.contains(stackTop(stack)) == true ) {
            //     print("Here 2");
            //     let lastToken = stack.popLast()
            //     print("Here 3");
            //     queue.append(lastToken!)
            // }
            
        }
    }

    while (stack.count > 0) {
        if (BRACKETS.contains(stackTop(stack)) == true) {
            //print("Invalid expression")
            return nil
        }

        let lastToken = stack.popLast()
        queue.append(lastToken!)
    }

    return queue
}

func calculateWithReversePolishNotation(_ queue: [String]) -> Double? {
    
    var stack: [String] = []

    for token in queue {
        if (isNumeric(token) == true) {
            stack.append(token)
        }
        else if (ARITHMETIC.contains(token) == true || FUNCTIONS.contains(token) == true) {
            if (token == "+" || token == "*" || token == "-" || token == "/" || token == "^") {
                if (stack.count < 2) {
                    //print("Not enough arguments")
                    return nil
                }

                let firstArgument = Double(stack.popLast()!)
                let secondArgument = Double(stack.popLast()!)
                var evaluatedResult: Double
                
                switch token {
                    case "+":
                        evaluatedResult = secondArgument! + firstArgument!
                        break
                    case "-":
                        evaluatedResult = secondArgument! - firstArgument!
                        break
                    case "*":
                        evaluatedResult = secondArgument! * firstArgument!
                        break
                    case "/":
                        if (token == "/" && firstArgument == 0) {
                            //print("Cannot divide by zero")
                            return nil
                        }

                        evaluatedResult = secondArgument! / firstArgument!
                        break
                    case "^":
                        evaluatedResult = pow(secondArgument!, firstArgument!)
                        break
                    default:
                        return nil                
                }
                
                stack.append(String(evaluatedResult))
            }
        }
    }

    if (stack.count != 1) {
        //print("Invalid result")
        return nil
    }
    else {
        let result: Double = Double(stack.popLast()!)!
        return result
    }
}

func isNumeric(_ input: String) -> Bool {
    let isNumber = Int(input)
    if isNumber != nil {
        return true
    }
    return false
}

func checkPrecedence(_ operatorToken: String) -> Int {
    if (operatorToken == "+" || operatorToken == "-") {
        return 1
    }
    else {
        return 2
    }
}

func stackTop(_ stack: [String]) -> String {
    return stack[stack.count-1]
}

// Lets test the caluclator
// let examples: [String] = [
//     "5+6",
//     "5-6",
//     "5*6",
//     "10/2",
//     "2^10",
//     "3/0",
//     "1+2-3*4/5",
//     "((1+2) * (3+4)) / (5+6) * 7/8",
//     "(1+2) * 2^10",
//     "((23 + 6) * 2)"
// ]

// for example in examples {
//     let result = evaluate(expression: example)
//     if let hasResult = result {
//         print("\(example)=\(hasResult)")
//     }
//     else {
//         print("\(example)=Incorrect")
//     }
// }