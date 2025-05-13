import XCTest

@testable import FEKit

final class ArrayTests: XCTestCase {
  func testAt() {
    let array = [1, 2, 3, 4, 5]

    XCTAssertEqual(array.at(0), 1)
    XCTAssertEqual(array.at(4), 5)
    XCTAssertEqual(array.at(5), nil)
    XCTAssertEqual(array.at(-1), 5)
    XCTAssertEqual(array.at(-5), 1)
    XCTAssertEqual(array.at(-6), nil)
  }

  func testConcat() {
    let array1 = [1, 2, 3]
    let array2 = [4, 5, 6]
    let array3 = [7, 8, 9]

    XCTAssertEqual(array1.concat(array2), [1, 2, 3, 4, 5, 6])
    XCTAssertEqual(array1.concat(array2, array3), [1, 2, 3, 4, 5, 6, 7, 8, 9])
    XCTAssertEqual(array1.concat(), [1, 2, 3])

    // Make sure original array is not modified
    XCTAssertEqual(array1, [1, 2, 3])
  }

  func testEntries() {
    let array = ["a", "b", "c"]
    let entries = array.entries()

    XCTAssertEqual(entries[0].0, 0)
    XCTAssertEqual(entries[0].1, "a")
    XCTAssertEqual(entries[1].0, 1)
    XCTAssertEqual(entries[1].1, "b")
    XCTAssertEqual(entries[2].0, 2)
    XCTAssertEqual(entries[2].1, "c")
  }

  func testEvery() {
    let array1 = [2, 4, 6, 8, 10]
    let array2 = [2, 4, 5, 8, 10]

    XCTAssertTrue(array1.every { $0 % 2 == 0 })
    XCTAssertFalse(array2.every { $0 % 2 == 0 })
    XCTAssertTrue([Int]().every { $0 > 0 })  // Empty array should return true
  }

  func testFill() {
    var array = [1, 2, 3, 4, 5]

    // Test filling entire array
    _ = array.fill(0)
    XCTAssertEqual(array, [0, 0, 0, 0, 0])

    // Test filling part of the array
    array = [1, 2, 3, 4, 5]
    _ = array.fill(0, start: 2)
    XCTAssertEqual(array, [1, 2, 0, 0, 0])

    // Test with start and end
    array = [1, 2, 3, 4, 5]
    _ = array.fill(0, start: 1, end: 4)
    XCTAssertEqual(array, [1, 0, 0, 0, 5])

    // Test with invalid range
    array = [1, 2, 3, 4, 5]
    _ = array.fill(0, start: 3, end: 2)
    XCTAssertEqual(array, [1, 2, 3, 4, 5])
  }

  func testFind() {
    let array = [5, 12, 8, 130, 44]

    XCTAssertEqual(array.find { $0 > 10 }, 12)
    XCTAssertEqual(array.find { $0 > 200 }, nil)
  }

  func testFindIndex() {
    let array = [5, 12, 8, 130, 44]

    XCTAssertEqual(array.findIndex { $0 > 10 }, 1)
    XCTAssertEqual(array.findIndex { $0 > 200 }, nil)
  }

  func testFindLast() {
    let array = [5, 12, 8, 130, 44]

    XCTAssertEqual(array.findLast { $0 > 10 }, 44)
    XCTAssertEqual(array.findLast { $0 > 200 }, nil)
  }

  func testFindLastIndex() {
    let array = [5, 12, 8, 130, 44]

    XCTAssertEqual(array.findLastIndex { $0 > 10 }, 4)
    XCTAssertEqual(array.findLastIndex { $0 > 200 }, nil)
  }

  func testFlat() {
    let array = [[1, 2], [3, 4], [5, 6]]
    XCTAssertEqual(array.flat(), [1, 2, 3, 4, 5, 6])
  }

  func testFlatMap() {
    let array = [1, 2, 3, 4]
    let result = array.flatMap { [$0, $0 * 2] }
    XCTAssertEqual(result, [1, 2, 2, 4, 3, 6, 4, 8])
  }

  func testIndexOf() {
    let array = ["apple", "banana", "orange", "banana"]

    XCTAssertEqual(array.indexOf("banana"), 1)
    XCTAssertEqual(array.indexOf("grape"), nil)
  }

  func testJoin() {
    let array = ["Wind", "Rain", "Fire"]

    XCTAssertEqual(array.join(), "Wind,Rain,Fire")
    XCTAssertEqual(array.join(separator: "-"), "Wind-Rain-Fire")
    XCTAssertEqual([1, 2, 3].join(separator: "; "), "1; 2; 3")
  }

  func testIncludes() {
    let array = [1, 2, 3]

    XCTAssertTrue(array.includes(1))
    XCTAssertFalse(array.includes(4))
  }

  func testMap() {
    let array = [1, 4, 9, 16]
    let result = array.map { sqrt(Double($0)) }

    XCTAssertEqual(result, [1.0, 2.0, 3.0, 4.0])
  }

  func testReduce() {
    let array = [1, 2, 3, 4]
    let sum = array.reduce(0) { $0 + $1 }

    XCTAssertEqual(sum, 10)
  }

  func testReduceRight() {
    let array = ["a", "b", "c"]
    let result = array.reduceRight("") { $0 + $1 }

    XCTAssertEqual(result, "cba")
  }

  func testShift() {
    var array = [1, 2, 3]
    let first = array.shift()

    XCTAssertEqual(first, 1)
    XCTAssertEqual(array, [2, 3])

    // Test empty array
    var emptyArray: [Int] = []
    let emptyResult = emptyArray.shift()

    XCTAssertNil(emptyResult)
    XCTAssertEqual(emptyArray, [])
  }

  func testPop() {
    var array = [1, 2, 3]
    let last = array.pop()

    XCTAssertEqual(last, 3)
    XCTAssertEqual(array, [1, 2])

    // Test empty array
    var emptyArray: [Int] = []
    let emptyResult = emptyArray.pop()

    XCTAssertNil(emptyResult)
    XCTAssertEqual(emptyArray, [])
  }

  func testSlice() {
    let array = [1, 2, 3, 4, 5]

    XCTAssertEqual(array.slice(), [1, 2, 3, 4, 5])
    XCTAssertEqual(array.slice(start: 2), [3, 4, 5])
    XCTAssertEqual(array.slice(start: 2, end: 4), [3, 4])
    XCTAssertEqual(array.slice(start: -2), [4, 5])
    XCTAssertEqual(array.slice(start: 2, end: -1), [3, 4])
    XCTAssertEqual(array.slice(start: -3, end: -1), [3, 4])
  }

  func testSome() {
    let array1 = [1, 2, 3, 4, 5]
    let array2 = [1, 3, 5, 7, 9]

    XCTAssertTrue(array1.some { $0 % 2 == 0 })
    XCTAssertFalse(array2.some { $0 % 2 == 0 })
    XCTAssertFalse([Int]().some { $0 > 0 })  // Empty array should return false
  }

  func testSplice() {
    var array = [1, 2, 3, 4, 5]
    let removed = array.splice(start: 1, deleteCount: 2)

    XCTAssertEqual(removed, [2, 3])
    XCTAssertEqual(array, [1, 4, 5])

    // Test adding elements
    array = [1, 2, 3, 4, 5]
    let removed2 = array.splice(start: 1, deleteCount: 2, elementsToAdd: [10, 20])

    XCTAssertEqual(removed2, [2, 3])
    XCTAssertEqual(array, [1, 10, 20, 4, 5])

    // Test negative index
    array = [1, 2, 3, 4, 5]
    let removed3 = array.splice(start: -2, deleteCount: 1)

    XCTAssertEqual(removed3, [4])
    XCTAssertEqual(array, [1, 2, 3, 5])
  }

  func testSort() {
    var array = [3, 1, 4, 1, 5]
    let result = array.sort { $0 < $1 }

    XCTAssertEqual(result, [1, 1, 3, 4, 5])
    XCTAssertEqual(array, [1, 1, 3, 4, 5])  // Original array should be modified
  }

  func testToSorted() {
    let array = [3, 1, 4, 1, 5]
    let sorted = array.toSorted { $0 < $1 }

    XCTAssertEqual(sorted, [1, 1, 3, 4, 5])
    XCTAssertEqual(array, [3, 1, 4, 1, 5])  // Original array should not be modified
  }

  func testToSpliced() {
    let array = [1, 2, 3, 4, 5]
    let result = array.toSpliced(start: 1, deleteCount: 2, elementsToAdd: [10, 20])

    XCTAssertEqual(result, [1, 10, 20, 4, 5])
    XCTAssertEqual(array, [1, 2, 3, 4, 5])  // Original array should not be modified
  }

  func testUnshift() {
    var array = [3, 4, 5]
    let length = array.unshift(1, 2)

    XCTAssertEqual(length, 5)
    XCTAssertEqual(array, [1, 2, 3, 4, 5])
  }

  func testReverse() {
    var array = [1, 2, 3, 4, 5]
    let result = array.reverse()

    XCTAssertEqual(result, [5, 4, 3, 2, 1])
    XCTAssertEqual(array, [5, 4, 3, 2, 1])  // Original array should be modified
  }

  func testToReversed() {
    let array = [1, 2, 3, 4, 5]
    let reversed = array.toReversed()

    XCTAssertEqual(reversed, [5, 4, 3, 2, 1])
    XCTAssertEqual(array, [1, 2, 3, 4, 5])  // Original array should not be modified
  }

  func testWith() {
    let array = [1, 2, 3, 4, 5]
    let result = array.with(index: 2, value: 10)

    XCTAssertEqual(result, [1, 2, 10, 4, 5])
    XCTAssertEqual(array, [1, 2, 3, 4, 5])  // Original array should not be modified
  }
}
