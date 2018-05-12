/** 
 * @Author: Valentin Kirilov
 * @Date: 2018-04-29 16:21:13 
 * @Desc: Swift Programming Course 
 *
 * Homework 2
 * Task 1
 *
 * FMU, Sofia University 
 */

import Foundation

struct Point {
    var x: Double
    var y: Double
}

extension Point: Equatable {
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs == rhs
    }

}

struct Rect {
	//top-left
    var top:Point
    var width: Double
    var height: Double
    
    init(x: Double, y: Double, width: Double, height: Double) {
        top = Point(x: x, y: y)
        self.width = width
        self.height = height
    }
}

extension Rect: Equatable {
    
    static func == (lhs: Rect, rhs: Rect) -> Bool {
        return lhs == rhs
    }

}



protocol Printable {
	var text: String { get }
	func printMe()
}

protocol VisualComponent: class {
	var boundingBox: Rect { get }
	var parent: VisualComponent? { get }
	func draw()
}

protocol VisualGroup: VisualComponent {
	var numChildren: Int { get }

	var children: [VisualComponent] { get }

	func add(child: VisualComponent)

	func remove(child: VisualComponent)

	func removeChild(at: Int)
}



class Triangle {

    var a: Point
    var b: Point
    var c: Point
    var parentElement: VisualComponent?

    init(a: Point, b: Point, c: Point) {
        self.a = a
        self.b = b
        self.c = c
        self.parentElement = nil
    }

}

extension Triangle: VisualComponent {

    var boundingBox: Rect { 
        get {
            let ax: Double = a.x
            let bx: Double = b.x;
            let cx: Double = c.x;
            
            let ay: Double = a.y;
            let by: Double = b.y;
            let cy: Double = c.y;

            let xMax: Double = ax > bx ? (ax > cx ? ax : cx) : (bx > cx ? bx : cx);
            let yMax: Double = ay > by ? (ay > cy ? ay : cy) : (by > cy ? by : cy);
            let xMin: Double = ax < bx ? (ax < cx ? ax : cx) : (bx < cx ? bx : cx);
            let yMin: Double = ay < by ? (ay < cy ? ay : cy) : (by < cy ? by : cy);

            return Rect(x: xMin, y: yMin, width: xMax - xMin, height: yMax - yMin)
        }
    }

	var parent: VisualComponent? { 
        get {
            return self.parentElement
        }
    }
	
    func draw() {
        let boundingBox: Rect = self.boundingBox
        print("Draw triangle: Top: \(boundingBox.top); Width: \(boundingBox.width); Height: \(boundingBox.height)")
    }

}

extension Triangle: Printable {

    var text: String { 
        get {
            return "Triangle: A:(\(a.x), \(a.y)); B:(\(b.x), \(b.y)); C:(\(c.x), \(c.y)); "
        }
    }

    func printMe() {
        print(self.text)
    }    

}

extension Triangle: Equatable {
    
    static func == (lhs: Triangle, rhs: Triangle) -> Bool {
        return lhs == rhs
    }

}



class Rectangle {

    var rectangle: Rect
    var parentElement: VisualComponent?

    init(x: Int, y: Int, width: Int, height: Int) {
        self.rectangle = Rect(x: Double(x), y: Double(y), width: Double(width), height: Double(height))
        self.parentElement = nil
    }

}

extension Rectangle: VisualComponent {
    
    var boundingBox: Rect { 
        get {
            return self.rectangle
        }
    }
	var parent: VisualComponent? { 
        get {
            return self.parentElement
        }
    }
	
    func draw() {
        let boundingBox: Rect = self.boundingBox
        print("Draw rectangle: Top: \(boundingBox.top); Width: \(boundingBox.width); Height: \(boundingBox.height)")
    }

}

extension Rectangle: Printable {
    
    var text: String { 
        get {
            return "Rectangle: X:\(self.rectangle.top.x), Y:\(self.rectangle.top.y), Width:\(self.rectangle.width), Height:\(self.rectangle.height);"
        }
    }

    func printMe() {
        print(self.text)
    }

}

extension Rectangle: Equatable {
    
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs == rhs
    }

}



class Circle {

    var center: Point
    var radius: Double
    var parentElement: VisualComponent?

    init(x: Int, y:Int, r: Double) {
        self.center = Point(x: Double(x), y: Double(y))
        self.radius = r
        self.parentElement = nil
    }
    
}

extension Circle: VisualComponent {
    
    var boundingBox: Rect { 
        get {
            let xMin: Double = self.center.x - self.radius
            let yMin: Double = self.center.y - self.radius
            let xMax: Double = self.center.x + self.radius
            let yMax: Double = self.center.y + self.radius

            return Rect(x: xMin, y: yMin, width: xMax - xMin, height: yMax - yMin)
        }
    }

	var parent: VisualComponent? { 
        get {
            return self.parentElement
        }
    }
	
    func draw() {
        let boundingBox: Rect = self.boundingBox
        print("Draw circle: Top: \(boundingBox.top); Width: \(boundingBox.width); Height: \(boundingBox.height)")
    }

}

extension Circle: Printable {
    
    var text: String { 
        get {
            return "Circle: X:\(self.center.x), Y:\(self.center.y), Radius:\(self.radius);"
        }
    }

    func printMe() {
        print(self.text)
    }

}

extension Circle: Equatable {
    
    static func == (lhs: Circle, rhs: Circle) -> Bool {
        return lhs == rhs
    }

}



class Path {

    var points: [Point]
    var parentElement: VisualComponent?

    init(points: [Point]) {
        self.points = points
        self.parentElement = nil
    }

}

extension Path: VisualComponent {
    
    var boundingBox: Rect { 
        get {
            var xMin: Double = self.points[0].x;
            var yMin: Double = self.points[0].y;
            var xMax: Double = self.points[0].x;
            var yMax: Double = self.points[0].y;

            for point in self.points {
                if point.x < xMin {
                    xMin = point.x
                }
            }

            for point in self.points {
                if point.y < yMin {
                    yMin = point.y
                }
            }

            for point in self.points {
                if point.x > xMax {
                    xMax = point.x
                }
            }

            for point in self.points {
                if point.y > yMax {
                    yMax = point.y
                }
            }

            return Rect(x: xMin, y: yMin, width: xMax - xMin, height: yMax - yMin)
        }
    }
	var parent: VisualComponent? { 
        get {
            return self.parentElement
        }
    }
	
    func draw() {
        let boundingBox: Rect = self.boundingBox
        print("Draw path: Top: \(boundingBox.top); Width: \(boundingBox.width); Height: \(boundingBox.height)")
    }

}

extension Path: Printable {
    
    var text: String { 
        get {
            var printable: String = "Path: ["

            for point in self.points {
                printable += "(\(point.x), \(point.y)), "
            }

            printable += "];"
            return printable
        }
    }

    func printMe() {
        print(self.text)
    }
    
}

extension Path: Equatable {
    
    static func == (lhs: Path, rhs: Path) -> Bool {
        return lhs == rhs
    }

}



class HGroup {

    var elements: [VisualComponent] = []
    var parentElement: VisualComponent?;

    init() {
        self.parentElement = nil
    }

}

extension HGroup: VisualComponent {
    
    var boundingBox: Rect { 
        get {
            return Rect(x: 0, y: 0, width: 0, height: 0)
        }
    }

	var parent: VisualComponent? { 
        get {
            return self.parentElement
        }
    }
	func draw() {
        print("TODO")
    }

}

extension HGroup: VisualGroup {
	
    var numChildren: Int { 
        get {
            return self.elements.count
        }
    }
	
	var children: [VisualComponent] { 
        get {
            return self.elements
        }
    }
	
	func add(child: VisualComponent) {
        self.elements.append(child)
        //child.parentElement = self
    }
	
	func remove(child: VisualComponent) {
        var index: Int = 0
        for element in self.elements {
            if element === child {
                self.removeChild(at: index)
            }
            index += 1
        }
    }
	
	func removeChild(at: Int) {
        self.elements.remove(at: at);
    }

}

extension HGroup: Printable {

    var text: String { 
        get {
            if numChildren > 0 {
                var printable: String = "HGroup(["
                for element in self.elements {
                    printable += String(describing: element) + ", "
                }
                printable += "]"
                return printable
            }
            else {
                return "An empty HGroup"
            }
        }
    }

    func printMe() {
        print(self.text)
    }

}



class VGroup {

    var elements: [VisualComponent] = []
    var parentElement: VisualComponent?;

    init() {
        self.parentElement = nil
    }

}

extension VGroup: VisualComponent {
    
    var boundingBox: Rect { 
        get {
            return Rect(x: 0, y: 0, width: 0, height: 0)
        }
    }

	var parent: VisualComponent? { 
        get {
            return self.parentElement
        }
    }
	func draw() {
        print("TODO")
    }

}

extension VGroup: VisualGroup {
    
    var numChildren: Int { 
        get {
            return self.elements.count
        }
    }
	
	var children: [VisualComponent] { 
        get {
            return self.elements
        }
    }
	
	func add(child: VisualComponent) {
        self.elements.append(child)
        //child.parentElement = self
    }
	
	func remove(child: VisualComponent) {
        var index: Int = 0
        for element in self.elements {
            if element === child {
                self.removeChild(at: index)
            }
            index += 1
        }
    }
	
	func removeChild(at: Int) {
        self.elements.remove(at: at);
    }

}

extension VGroup: Printable {

    var text: String { 
        get {
            if numChildren > 0 {
                var printable: String = "VGroup(["
                for element in self.elements {
                    printable += String(describing: element) + ", "
                }
                printable += "]"
                return printable
            }
            else {
                return "An empty VGroup"
            }
        }
    }

    func printMe() {
        print(self.text)
    }

}


// Lets make some tests

// // Task 1
// var point1: Point = Point(x: 0, y: 0)
// var point2: Point = Point(x: 1, y: 1)
// var point3: Point = Point(x: 2, y: 2)

// var triangle: Triangle = Triangle(a: point1, b: point2, c: point3)
// triangle.printMe()
// triangle.draw()

// var rectangle: Rectangle = Rectangle(x: 0, y: 0, width: 10, height: 15)
// rectangle.printMe()
// rectangle.draw()

// var circle: Circle = Circle(x: 0, y: 0, r: 3)
// circle.printMe()
// circle.draw()

// var path: Path = Path(points: [point1, point2, point3])
// path.printMe()
// path.draw()

// var hGroup: HGroup = HGroup()
// hGroup.printMe()

// hGroup.add(child: triangle)
// hGroup.printMe()

// hGroup.add(child: rectangle)
// hGroup.add(child: circle)
// hGroup.printMe()

// hGroup.removeChild(at: 1)
// hGroup.printMe()

// hGroup.remove(child: triangle)
// hGroup.printMe()

// var vGroup: VGroup = VGroup()
// vGroup.printMe()

// vGroup.add(child: triangle)
// vGroup.printMe()

// vGroup.add(child: rectangle)
// vGroup.add(child: circle)
// vGroup.printMe()

// vGroup.removeChild(at: 1)
// vGroup.printMe()

// vGroup.remove(child: triangle)
// vGroup.printMe()