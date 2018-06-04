/** 
 * @Author: Valentin Kirilov
 * @Date: 2018-06-04 13:43:15 
 * @Desc: Swift Programming Course 
 *
 * Homework 3
 * Task 2
 *
 * FMU, Sofia University 
 */

class List<T> {
    var value: T
    var next: List<T>?

    init(value:T) {
        self.value = value
    }
}

extension List {
    subscript(index: Int) -> T? {
        var currentNode = self

        for i in 0...index {
            if i == index {
                return currentNode.value
            }
            else if let node = currentNode.next {                
                currentNode = node
            }
            else {
                return nil
            }
        }
        
        return nil
    }
}

extension List {
 	var length: Int {
        var listLength = 1
        var currentNode = self
        
        while true {
            if let node = currentNode.next {
                currentNode = node
                listLength += 1
            }
            else {
                return listLength
            }
        }
 	}
}

extension List {
 	func reverse() {
 	    let listLength = self.length
        var values: [T] = []
        for i in 0..<listLength {
            values.append(self[i]!)
        }

        var currentNode = self
        for i in 0..<listLength {
            currentNode.value = values[listLength-i-1]
            if let node = currentNode.next {
                currentNode = node
            }
        }
 	}
}

/*
let listInt1 = List(value: 1)
let listInt2 = List(value: 2)
let listInt3 = List(value: 3)
let listInt4 = List(value: 4)
let listInt5 = List(value: 5)

listInt1.next = listInt2
listInt2.next = listInt3
listInt3.next = listInt4
listInt4.next = listInt5

print(listInt1.value)
print(listInt1.next!.value)
print(listInt1.next!.next!.value)
print(listInt1.next!.next!.next!.value)
print(listInt1.next!.next!.next!.next!.value)

let subscript0: Int? = listInt1[0]
if let subscriptValue = subscript0 {
    print(subscriptValue)
}

let subscript2: Int? = listInt1[2]
if let subscriptValue = subscript2 {
    print(subscriptValue)
}

let subscript4: Int? = listInt1[5]
if let subscriptValue = subscript4 {
    print(subscriptValue)
}
else {
    print("Nil")
}

print(listInt1.length)
print(listInt3.length)
print(listInt5.length)

listInt1.reverse()
print(listInt1.value)
print(listInt1.next!.value)
print(listInt1.next!.next!.value)
print(listInt1.next!.next!.next!.value)
print(listInt1.next!.next!.next!.next!.value)


let listStringA = List(value: "A")
let listStringB = List(value: "B")
let listStringC = List(value: "C")

listStringA.next = listStringB
listStringB.next = listStringC
print(listStringA.length)
*/