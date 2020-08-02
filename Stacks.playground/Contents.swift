// Copyright (c) 2019 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

public struct User {
    let name: String
    let age: Int
}

public struct Stack<Element> {
    public var storage: [Element] = []

    public init() { }

    public init(_ elements: [Element]) {
        storage = elements
    }

    public mutating func push(_ element: Element) {
        storage.append(element)
    }

    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }

    public func peek() -> Element? {
        storage.last
    }

    public var isEmpty: Bool {
        peek() == nil
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        """
        ----top----
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        --------
        """
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

example(of: "Stack Elemet", action: {
    var stack = Stack<User>()
    let lucas = User(name: "Lucas", age: 32)
    let mariana = User(name: "Mariana", age: 24)
    stack.storage = [lucas, mariana]
    stack.description
})

example(of: "init from arrat", action: {
    let array = ["A","B","C","D"]
    let stack = Stack(array)
    print(stack)
})

example(of: "init array literal") {
    let stack: Stack = [1,2,3,4]
    print(stack)
}

func isUnbalaced(text: String) -> Bool {
    var points = 0
    for char in text {
        if char == "(" { points += 1}
        if char == ")" { points -= 1 }
    }
    return points != 0
}

func printReversedOrder(array: [String]) {
    var stack = Stack(array)
    var reversed: [String] = []
    for _ in stack.storage {
        if let elemet = stack.storage.popLast() {
            reversed.append(elemet)
        }
    }
    print(reversed)
}

func printReversedOrder2(array: [String]) {
    var myList = array
    while myList.last != nil {
        print(myList.last!)
        myList.popLast()
    }
}

func isTextUnbalaced(_ text: String) -> Bool {
    var score = 0
    for (index, char) in text.enumerated() {
        if char == ")" {
            score += 1
            for (index2, char2) in text.enumerated() {
                if char2 == ")" && index2 >= index {
                    score -= 1
                }
            }
        }
    }
    return score != 0
}

func checkParentheses(_ text: String) -> Bool {
    var stack = Stack<Character>()
    for char in text {
        if char == "(" {
            stack.push(char)
        } else if char == ")" {
            if stack.isEmpty { return false }
            stack.pop()
        }
    }
    return stack.isEmpty
}

example(of: "reverse 1", action: {
    let myList = ["a","b","c","d"]
    printReversedOrder(array: myList)
})

example(of: "reverse 2", action: {
    let myList = ["a","b","c","d"]
    printReversedOrder2(array: myList)
})

example(of: "unbalaced parentheses") {
    let text1 = "(Saassasa)"
    let text2 = "kk)(ssa()"
    let text3 = "sahuashuas"
    let text4 = "(SAASsa))"
    isTextUnbalaced(text1)
    isTextUnbalaced(text2)
    isTextUnbalaced(text3)
    isTextUnbalaced(text4)
}

example(of: "check parethenses") {
    let text1 = "(Saassasa)"
    let text2 = "kk)(ssa()"
    let text3 = "sahuashuas"
    let text4 = "(SAASsa))"
    checkParentheses(text1)
    checkParentheses(text2)
    checkParentheses(text3)
    checkParentheses(text4)
}
