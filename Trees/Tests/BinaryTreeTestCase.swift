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

final class BinaryTreeTestCase: XCTestCase {
    var tree: BinaryNode<Int> = {
        let zero = BinaryNode(value: 0)
        let one = BinaryNode(value: 1)
        let five = BinaryNode(value: 5)
        let seven = BinaryNode(value: 7)
        let eight = BinaryNode(value: 8)
        let nine = BinaryNode(value: 9)
        
        seven.leftChild = one
        one.leftChild = zero
        one.rightChild = five
        seven.rightChild = nine
        nine.leftChild = eight
        
        return seven
    }()
    
    func test_visualizeBinaryTree() {
        print(tree)
    }
    
    func test_traverseInOrder() {
        var testArray: [Int] = []
        
        tree.traverseInOrder { testArray.append($0) }
        XCTAssertEqual(testArray, [0, 1, 5, 7, 8, 9])
    }
    
    func test_traversePreOrder() {
        var testArray: [Int] = []
        
        tree.traversePreOrder { testArray.append($0) }
        XCTAssertEqual(testArray, [7, 1, 0, 5, 9, 8])
    }
    
    func test_traversePostOrder() {
        var testArray: [Int] = []
        
        tree.traversePostOrder { testArray.append($0) }
        XCTAssertEqual(testArray, [0, 5, 1, 8, 9, 7])
    }
    
    // MARK: Serialization and Deserialization
    func serialize<T>(_ node: BinaryNode<T>) -> [T?] {
        var array: [T?] = []
        node.traversePreOrderOptional { array.append($0) }
        return array
    }
    
    func deserialize<T>(_ array: inout [T?]) -> BinaryNode<T>? {
        // Remove last is better than remove first
        guard let value = array.removeLast() else {
            return nil
        }
        
        let node = BinaryNode(value: value)
        node.leftChild = deserialize(&array)
        node.rightChild = deserialize(&array)
        
        return node
    }
    
    func deserialize<T>(_ array: [T?]) -> BinaryNode<T>? {
        // By doing one reversion, we are optimizing so we don't use remove first multiple times
        var reversed = Array(array.reversed())
        return deserialize(&reversed)
    }
    
    func test_serializeTree(){
        let expectedArray = [7, 1, 0, nil, nil, 5, nil, nil, 9, 8, nil, nil, nil]
        let serializedTree = serialize(tree)
        XCTAssertEqual(serializedTree, expectedArray)
    }
    
    func test_deserializeArray(){
        var initialArray = [7, 1, 0, nil, nil, 5, nil, nil, 9, 8, nil, nil, nil]
        let deserializedTree = deserialize(initialArray)
        
        XCTAssertEqual(deserializedTree?.description, tree.description)

        
    }
}
