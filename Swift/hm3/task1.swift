/** 
 * @Author: Valentin Kirilov
 * @Date: 2018-06-04 13:13:13 
 * @Desc: Swift Programming Course 
 *
 * Homework 3
 * Task 1
 *
 * FMU, Sofia University 
 */

func sort(closures:[(Double) -> Double], sequence: [Double]) -> [(Double) -> Double] {
    return closures.sorted(by: {
        for seq in sequence {
            //print($1(seq))
            //print($0(seq))
            if ($1(seq) < $0(seq)) {
                //print("false");
                return false
            }
        }
        //print("true");
        return true
    })
}

let sortedClosures1 = sort(closures: [{return $0 * $0}, {return $0 * $0 * $0}], sequence: [1, 2, 3, 4, 5]) 
//print(sortedClosures1[0](2))
//print(sortedClosures1[1](2))

let sortedClosures2 = sort(closures: [{return $0 * $0}, {return $0 * $0 * $0}], sequence: [-1, -2, -3, -4, -5])
//print(sortedClosures2[0](2))
//print(sortedClosures2[1](2))