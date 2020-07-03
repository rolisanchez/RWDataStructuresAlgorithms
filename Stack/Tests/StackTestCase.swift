/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import DataStructures

final class StackTestCase: XCTestCase {
    var stack = Stack<Int>()
    
    override func setUp() {
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.push(4)
    }
    
    func test_push(){
        XCTAssertEqual(stack.description, "1 2 3 4")
    }
    
    func test_pop() {
        XCTAssertEqual(stack.pop(), 4)
    }
    
    func test_peek() {
        XCTAssertEqual(stack.peek(), 4)
    }
    
    func test_isEmpty(){
        XCTAssertFalse(stack.isEmpty)
    }
    
    func test_initWithArray() {
        let array = [1, 2, 3, 4]
        XCTAssertEqual(stack, Stack(array))
    }
    
    func test_arrayLiteral(){
        let stack: Stack = ["Blueberry", "plain", "potato"]
        
        XCTAssertEqual(stack, ["Blueberry", "plain", "potato"])
    }
    
    func hasBalancedParentheses(_ checkString: String) -> Bool {
        var parenthesesStack = Stack<Character>()
        
        for char in checkString {
            if char == "(" {
                parenthesesStack.push(char)
            } else if char == ")" {
                // Return early if trying to close unopened parentheses
                if stack.isEmpty {
                    return false
                } else {
                    parenthesesStack.pop()
                }
            }
        }
        return parenthesesStack.isEmpty
    }
    func test_balancedParentheses() {
        let balancedString = "hello(world)()"
        XCTAssertTrue(hasBalancedParentheses(balancedString))
    }
    
    func test_unbalancedParentheses() {
        let unbalancedString = "(hello(world"
        XCTAssertFalse(hasBalancedParentheses(unbalancedString))
    }
}
