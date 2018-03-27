
/** 
 * @Author: Valentin Kirilov
 * @Date: 2018-03-26 20:39:24 
 * @Desc: Swift Programming Course
 *
 * Homework 1
 * Task 1
 *
 * FMU, Sofia University
 */

func generate(input: String, type: String) -> [String] {
    var results: [String] = [];

    if type == "P" {
        let fromIndex = 0
        generatePermutation(&results, input: input, from: fromIndex)
    }
    else if type == "C" {
        let inputCharacters = Array(input)
        let fromIndex = 0
        let currentString = ""
        generateCombination(&results, input: inputCharacters, from: fromIndex, current: currentString)
    }

    return results;
}

func generatePermutation(_ results: inout [String], input inputString: String, from startIndex: Int) {
    if startIndex == inputString.count {
        results.append(inputString)
    }
    else {
        for currentIndex in startIndex..<inputString.count {
            let newString = swapStringLetters(target: inputString, from: startIndex, to: currentIndex)
            let newIndex = startIndex + 1
            generatePermutation(&results, input: newString, from: newIndex)
        }
    }
}

func generateCombination(_ results: inout [String], input inputCharacters: [Character], from currentIndex: Int, current currentString: String) {
    if currentString.count == inputCharacters.count {
        results.append(currentString)
    }
    else {
        for i in 0..<inputCharacters.count {
            let newString = currentString + String(inputCharacters[i])
            let newIndex = currentIndex + 1
            generateCombination(&results, input: inputCharacters, from: newIndex, current: newString)
        }
    }    
}

func swapStringLetters(target inputString: String, from firstIndex: Int, to secondIndex: Int) -> String {
    var characters = Array(inputString)
    let temp: Character = characters[firstIndex]

    characters[firstIndex] = characters[secondIndex]
    characters[secondIndex] = temp
    
    let newString = String(characters)
    return newString
}

// Test permutations
let task1Result1 = generate(input: "AB", type: "P")
print(task1Result1)

let task1Result2 = generate(input: "ABC", type: "P")
print(task1Result2)

let task1Result3 = generate(input: "ABCD", type: "P")
print(task1Result3)

// Test combinations
let task2Result1 = generate(input: "AB", type: "C")
print(task2Result1)

let task2Result2 = generate(input: "ABC", type: "C")
print(task2Result2)

let task2Result3 = generate(input: "ABCD", type: "C")
print(task2Result3)