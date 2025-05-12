import XCTest

@testable import FEKit

final class StringTests: XCTestCase {
  func testFromCharCode() {
    // Test fromCharCode function
    XCTAssertEqual(String.fromCharCode(charCode: [65, 66, 67]), "ABC")
    XCTAssertEqual(String.fromCharCode(charCode: [72, 101, 108, 108, 111]), "Hello")
    XCTAssertEqual(String.fromCharCode(charCode: []), "")

    // Test surrogate pairs handling in fromCharCode
    // "𝌆" can be represented with surrogate pairs \uD834\uDF06
    let surrogatePairCharCode = [0xD834, 0xDF06]
    XCTAssertEqual(String.fromCharCode(charCode: surrogatePairCharCode), "𝌆")
  }

  func testFromCodePoint() {
    // Test fromCodePoint function
    XCTAssertEqual(String.fromCodePoint(codePoint: [65, 66, 67]), "ABC")
    XCTAssertEqual(String.fromCodePoint(codePoint: [72, 101, 108, 108, 111]), "Hello")
    XCTAssertEqual(String.fromCodePoint(codePoint: []), "")

    // Test handling higher code points in fromCodePoint
    // "𝌆" Unicode code point is U+1D306
    XCTAssertEqual(String.fromCodePoint(codePoint: [0x1D306]), "𝌆")

    // Test filtering invalid code points
    XCTAssertEqual(String.fromCodePoint(codePoint: [65, -1, 67]), "AC")
    XCTAssertEqual(String.fromCodePoint(codePoint: [65, 0x110000, 67]), "AC")
  }

  func testAt() {
    XCTAssertEqual("Hello".at(0), "H")
    XCTAssertEqual("Hello".at(4), "o")
    XCTAssertEqual("Hello".at(5), nil)
    XCTAssertEqual("Hello".at(-1), "o")
    XCTAssertEqual("Hello".at(-5), "H")
    XCTAssertEqual("Hello".at(-6), nil)
    XCTAssertEqual("Hello".at(1), "e")
    XCTAssertEqual("Hello".at(-2), "l")
    XCTAssertEqual("Hello".at(6), nil)
    XCTAssertEqual("Hello".at(-6), nil)
    XCTAssertEqual("Hello".at(10), nil)
  }

  func testCharAt() {
    XCTAssertEqual("Hello".charAt(0), "H")
    XCTAssertEqual("Hello".charAt(4), "o")
    XCTAssertEqual("Hello".charAt(5), "")
    XCTAssertEqual("Hello".charAt(-1), "")
    XCTAssertEqual("Hello".charAt(-5), "")
    XCTAssertEqual("Hello".charAt(6), "")
    XCTAssertEqual("Hello".charAt(-6), "")
    XCTAssertEqual("Hello".charAt(10), "")
  }

  func testCharCodeAt() {
    XCTAssertEqual("Hello".charCodeAt(0), 72)
    XCTAssertEqual("Hello".charCodeAt(4), 111)
    XCTAssertEqual("Hello".charCodeAt(5), nil)
    XCTAssertEqual("Hello".charCodeAt(-1), nil)
  }

  func testCodePointAt() {
    XCTAssertEqual("☃".codePointAt(0), 9731)
    XCTAssertEqual("Hello".codePointAt(4), 111)
    XCTAssertEqual("Hello".codePointAt(5), nil)
    XCTAssertEqual("Hello".codePointAt(-1), nil)
  }

  func testConcat() {
    XCTAssertEqual("Hello".concat(" World"), "Hello World")
    XCTAssertEqual("Hello".concat(" World", "!"), "Hello World!")
    XCTAssertEqual("Hello".concat(), "Hello")
  }

  func testEndsWith() {
    XCTAssertEqual("Hello".endsWith("o"), true)
    XCTAssertEqual("Hello".endsWith("o", position: 4), true)
    XCTAssertEqual("Hello".endsWith("o", position: 5), false)
    XCTAssertEqual("Hello".endsWith("o", position: 6), false)
    XCTAssertEqual("Hello".endsWith("o", position: -1), false)
  }

  func testIncludes() {
    XCTAssertEqual("Hello".includes("o"), true)
    XCTAssertEqual("Hello".includes("o", position: 4), true)
    XCTAssertEqual("Hello".includes("o", position: 5), false)
    XCTAssertEqual("Hello".includes("o", position: 6), false)
    XCTAssertEqual("Hello".includes("o", position: -1), false)

    /// words
    XCTAssertEqual("Hello".includes("He", position: 4), false)
    XCTAssertEqual("Hello".includes("He", position: 0), true)
    XCTAssertEqual("Hello".includes("He", position: 1), false)
    XCTAssertEqual("Hello".includes("He", position: 2), false)
    XCTAssertEqual("Hello".includes("He", position: 3), false)
    XCTAssertEqual("Hello".includes("He", position: 4), false)
    XCTAssertEqual("Hello".includes("He", position: 5), false)
    XCTAssertEqual("Hello".includes("He", position: 6), false)
  }

  func testIndexOf() {
    XCTAssertEqual("Hello".indexOf("o"), 4)
    XCTAssertEqual("Hello".indexOf("o", startIndex: 4), 4)
    XCTAssertEqual("Hello".indexOf("o", startIndex: 5), -1)
    XCTAssertEqual("Hello".indexOf("o", startIndex: -1), -1)
  }

  func testLastIndexOf() {
    let str = "Hello, World! Hello!"
    XCTAssertEqual(str.lastIndexOf("Hello"), 14)
    XCTAssertEqual(str.lastIndexOf("o"), 18)
    XCTAssertEqual(str.lastIndexOf("z"), -1)
    XCTAssertEqual(str.lastIndexOf("l", startIndex: 10), 3)
    XCTAssertEqual(str.lastIndexOf("o", startIndex: 5), 4)
    XCTAssertEqual(str.lastIndexOf("", startIndex: 19), 19)
    XCTAssertEqual(str.lastIndexOf("", startIndex: 5), 5)
    XCTAssertEqual(str.lastIndexOf(""), str.count)
    XCTAssertEqual(str.lastIndexOf("Hello", startIndex: 12), 0)
    XCTAssertEqual(str.lastIndexOf("", startIndex: 100), str.count)
  }

  func testLocaleCompare() {
    XCTAssertEqual("Hello".localeCompare("Hello"), .orderedSame)
    XCTAssertEqual("Hello".localeCompare("hello"), .orderedDescending)
    XCTAssertEqual("Hello".localeCompare("world"), .orderedAscending)

    let str = "café"
    XCTAssertEqual(str.localeCompare("cafe"), .orderedDescending)
    XCTAssertEqual(
      str.localeCompare("cafe", options: .caseInsensitive), .orderedDescending)
    XCTAssertEqual(str.localeCompare("cafe", options: .diacriticInsensitive), .orderedSame)
    XCTAssertEqual(str.localeCompare("cafe", options: .numeric), .orderedDescending)
    XCTAssertEqual(str.localeCompare("cafe", options: .widthInsensitive), .orderedDescending)
    XCTAssertEqual(str.localeCompare("cafe", options: .widthInsensitive), .orderedDescending)
    XCTAssertEqual(str.localeCompare("cafe", options: .widthInsensitive), .orderedDescending)
    XCTAssertEqual(str.localeCompare("cafe", options: .widthInsensitive), .orderedDescending)
    XCTAssertEqual(str.localeCompare("cafe", options: .widthInsensitive), .orderedDescending)
    XCTAssertEqual(str.localeCompare("cafe", options: .widthInsensitive), .orderedDescending)
  }

  func testLength() {
    XCTAssertEqual("Hello".length, 5)
    XCTAssertEqual("".length, 0)
  }
}
