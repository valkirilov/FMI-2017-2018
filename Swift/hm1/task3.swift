
/** 
 * @Author: Valentin Kirilov
 * @Date: 2018-03-27 14:39:01 
 * @Desc: Swift Programming Course 
 *
 * Homework 1
 * Task 3
 *
 * FMU, Sofia University 
 */

func findPath(input: [[String]]) -> [(Int, Int)]? {    
    let startPosition: (Int, Int)? = findStartPosition(input: input)

    if let hasStartPosition = startPosition {
        var solution: [(Int, Int)] = []
        var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: input[0].count), count: input.count)

        if makeMove(input: input, hasStartPosition.0, hasStartPosition.1, &visited, &solution) {
            return solution
        }
    }

    return nil;
}

func findStartPosition(input: [[String]]) -> (Int, Int)? {
    for y in 0..<input.count {
        for x in 0..<input[y].count {
            if input[y][x] == "^" {
                return (x, y)
            }
        }
    }
    return nil
}

func makeMove(input maze: [[String]], _ x: Int, _ y: Int, _ visited: inout [[Bool]], _ solution: inout [(Int, Int)]) -> Bool {
    if (x < 0 || y < 0 || x >= maze[0].count || y >= maze.count) {
        return false
    }

    let currentCell = (x, y)

    if visited[y][x] == true {
        return false
    }
    visited[y][x] = true

    if (maze[y][x] == "*") {
        solution.append(currentCell)
        return true
    }

    if (maze[y][x] == "1") {
        return false
    }

    solution.append(currentCell)

    if makeMove(input: maze, x, y+1, &visited, &solution) == true {
        return true
    }
    if makeMove(input: maze, x+1, y, &visited, &solution) == true {
        return true
    }
    if makeMove(input: maze, x-1, y, &visited, &solution) == true {
        return true
    }
    if makeMove(input: maze, x, y-1, &visited, &solution) == true {
        return true
    }
    
    solution.removeLast()
    
    return false
}

func print(maze: [[String]]) {
    for i in 0..<maze.count {
        print(maze[i])
    }
}

func print(maze: [[Bool]]) {
    for i in 0..<maze.count {
        print(maze[i])
    }
}

let maze1: [[String]] = [
    ["^", "0", "0", "0", "0", "0", "0", "1"],
    ["0", "1", "1", "1", "1", "1", "0", "0"],
    ["0", "0", "0", "0", "0", "1", "1", "1"],
    ["0", "1", "1", "1", "0", "1", "0", "0"],
    ["0", "1", "0", "1", "0", "0", "0", "1"],
    ["0", "0", "0", "1", "0", "1", "0", "*"],
]
let maze2: [[String]] = [
    ["^", "1", "0", "0", "0", "0", "0", "1"],
    ["0", "1", "1", "1", "1", "1", "0", "0"],
    ["0", "1", "0", "0", "0", "1", "1", "1"],
    ["0", "1", "1", "1", "0", "1", "0", "0"],
    ["0", "1", "0", "1", "0", "0", "0", "1"],
    ["0", "1", "0", "1", "0", "1", "0", "*"],
]
let maze3: [[String]] = [
    ["^", "1", "0", "0", "0", "0", "0", "0"],
    ["0", "1", "0", "1", "1", "1", "1", "0"],
    ["0", "1", "0", "1", "0", "0", "0", "0"],
    ["0", "1", "0", "1", "0", "1", "1", "1"],
    ["0", "1", "0", "1", "0", "0", "0", "1"],
    ["0", "0", "0", "1", "0", "1", "0", "*"],
]
let maze4: [[String]] = [
    ["1", "1", "0", "0", "0", "0", "0", "0"],
    ["0", "1", "0", "1", "1", "1", "1", "0"],
    ["0", "1", "0", "1", "^", "0", "0", "0"],
    ["0", "1", "0", "1", "0", "1", "1", "1"],
    ["0", "1", "0", "1", "0", "0", "0", "1"],
    ["0", "0", "0", "1", "0", "1", "0", "*"],
]

// Test with maze 1
let pathForMaze1: [(Int, Int)]? = findPath(input: maze1);

print("Maze 1")
if let path1 = pathForMaze1 {
    print(maze: maze1)
    print(path1)
}
else {
    print("There is no solution for this maze.")
}

// Test with maze 2
let pathForMaze2: [(Int, Int)]? = findPath(input: maze2);

print("\n\nMaze 2")
if let path2 = pathForMaze2 {
    print(maze: maze2)
    print(path2)
}
else {
    print("There is no solution for this maze.")
}

// Test with maze 3
let pathForMaze3: [(Int, Int)]? = findPath(input: maze3);

print("\n\nMaze 3")
if let path3 = pathForMaze3 {
    print(maze: maze3)
    print(path3)
}
else {
    print("There is no solution for this maze.")
}

// Test with maze 4
let pathForMaze4: [(Int, Int)]? = findPath(input: maze4);

print("\n\nMaze 4")
if let path4 = pathForMaze4 {
    print(maze: maze4)
    print(path4)
}
else {
    print("There is no solution for this maze.")
}