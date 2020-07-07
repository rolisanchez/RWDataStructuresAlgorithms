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

final class HeapTestCase: XCTestCase {
    private let unsortedInts = [1, 12, 3, 4, 1, 6, 8, 7]
    
    func test_init(){
        let heap = Heap(unsortedInts, areSorted: <)
        XCTAssertEqual(unsortedInts.sorted(by: >), Array(heap))
    }
    
    func test_peek() {
        let heap = Heap(unsortedInts, areSorted: >)
        XCTAssertEqual(heap.peek(), 12)
    }
    
    func test_removeRoot() {
        var heap = Heap(unsortedInts, areSorted: >)
        XCTAssertEqual(heap.removeRoot(), 12)
    }
    
    func test_remove() {
        var heap = Heap(unsortedInts, areSorted: >)
        let index = heap.getFirstIndex(of: 3)!
        XCTAssertEqual(heap.remove(at: index), 3)
        XCTAssertEqual(Array(heap), [1, 1, 4, 6, 7, 8, 12])

    }

    func test_insert() {
        var heap = Heap(unsortedInts, areSorted: >)
        heap.insert(5)
        XCTAssertEqual(Array(heap), [1, 1, 3, 4, 5, 6, 7, 8, 12])
    }
    
    func test_isHeap() {
        let maxHeapArray = [
                  5,
              4,      2,
            4, 3,    1
        ]
        XCTAssertTrue(maxHeapArray.isHeap(sortedBy: >))
        let minHeapArray = [
                  1,
              2,      10,
            3, 3,   11, 11
        ]
        XCTAssertTrue(minHeapArray.isHeap(sortedBy: <))
        let invalidHeapArray = [
               0,
            1,   -1
        ]
        XCTAssertFalse(invalidHeapArray.isHeap(sortedBy: >))
        XCTAssertFalse(invalidHeapArray.isHeap(sortedBy: <))
    }
}
