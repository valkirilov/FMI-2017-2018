/** 
 * @Author: Valentin Kirilov
 * @Date: 2018-06-04 18:18:26 
 * @Desc: Swift Programming Course 
 *
 * Homework 3
 * Task 3
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

extension List where T:Equatable {
 	func toSet() {
        var values: [T] = []
        var currentNode = self

        while true {
            if !values.contains(currentNode.value) {
                values.append(currentNode.value)

            }

            if let hasNext = currentNode.next {
                currentNode = hasNext    
            }
            else {
                break
            }

        }

        currentNode = self
        for i in 1..<values.count {
            let newNode = List(value: values[i])
            currentNode.value = values[i-1]
            currentNode.next = newNode

            currentNode = newNode
        }
 	}

    /*
    func printList() {
        var currentNode = self
            
        while true {
            print(currentNode.value)
            
            if let node = currentNode.next {
                currentNode = node
            }
            else {
                return
            }
        }
    }
    */
}


// let listInt1 = List(value: 1)
// let listInt2 = List(value: 2)
// let listInt3 = List(value: 3)
// let listInt4 = List(value: 1)
// let listInt5 = List(value: 2)
// let listInt6 = List(value: 3)
// let listInt7 = List(value: 4)
// let listInt8 = List(value: 1)
// let listInt9 = List(value: 4)
// let listInt10 = List(value: 1)

// listInt1.next = listInt2
// listInt2.next = listInt3
// listInt3.next = listInt4
// listInt4.next = listInt5
// listInt5.next = listInt6
// listInt6.next = listInt7
// listInt7.next = listInt8
// listInt8.next = listInt9
// listInt9.next = listInt10

// listInt1.toSet()

// listInt1.printList()