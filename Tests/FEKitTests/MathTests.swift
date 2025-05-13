import XCTest

@testable import FEKit

final class MathTests: XCTestCase {

  func testRandom() {
    // Test random() returns a value between 0 and 1
    let randomValue = Math.random()
    XCTAssertGreaterThanOrEqual(randomValue, 0.0)
    XCTAssertLessThan(randomValue, 1.0)

    // Test random(min:max:) returns a value in range
    let minValue = 5
    let maxValue = 10
    let randomRangeValue = Math.random(min: minValue, max: maxValue)
    XCTAssertGreaterThanOrEqual(randomRangeValue, minValue)
    XCTAssertLessThan(randomRangeValue, maxValue)

    // Test randomInt(min:max:) returns a value in range (inclusive)
    let randomIntValue = Math.randomInt(min: minValue, max: maxValue)
    XCTAssertGreaterThanOrEqual(randomIntValue, minValue)
    XCTAssertLessThanOrEqual(randomIntValue, maxValue)
  }

  func testRounding() {
    // Test round - matches JavaScript's behavior
    XCTAssertEqual(Math.round(3.5), 4)
    XCTAssertEqual(Math.round(3.4), 3)
    // JavaScript's Math.round(-3.5) is -3, not -4
    XCTAssertEqual(Math.round(-3.5), -3)
    XCTAssertEqual(Math.round(-3.4), -3)
    XCTAssertEqual(Math.round(-3.6), -4)

    // Test floor
    XCTAssertEqual(Math.floor(3.9), 3)
    XCTAssertEqual(Math.floor(-3.1), -4)
    XCTAssertEqual(Math.floor(-3.0), -3)

    // Test ceil
    XCTAssertEqual(Math.ceil(3.1), 4)
    XCTAssertEqual(Math.ceil(3.0), 3)
    XCTAssertEqual(Math.ceil(-3.9), -3)
    XCTAssertEqual(Math.ceil(-3.0), -3)

    // Test trunc
    XCTAssertEqual(Math.trunc(3.9), 3.0)
    XCTAssertEqual(Math.trunc(-3.9), -3.0)
    XCTAssertEqual(Math.trunc(-3.1), -3.0)
  }

  func testBasicMath() {
    // Test abs
    XCTAssertEqual(Math.abs(-5.5), 5.5)
    XCTAssertEqual(Math.abs(5.5), 5.5)

    // Test min and max
    XCTAssertEqual(Math.min(10.5, 20.3), 10.5)
    XCTAssertEqual(Math.max(10.5, 20.3), 20.3)

    // Test pow
    XCTAssertEqual(Math.pow(2.0, 3.0), 8.0)
    XCTAssertEqual(Math.pow(4.0, 0.5), 2.0)

    // Test sqrt
    XCTAssertEqual(Math.sqrt(16.0), 4.0)
    XCTAssertEqual(Math.sqrt(2.0), sqrt(2.0))
  }

  func testTrigonometry() {
    // Test sin
    XCTAssertEqual(Math.sin(0), 0.0, accuracy: 0.0001)
    XCTAssertEqual(Math.sin(Double.pi / 2), 1.0, accuracy: 0.0001)

    // Test cos
    XCTAssertEqual(Math.cos(0), 1.0, accuracy: 0.0001)
    XCTAssertEqual(Math.cos(Double.pi), -1.0, accuracy: 0.0001)

    // Test tan
    XCTAssertEqual(Math.tan(0), 0.0, accuracy: 0.0001)
    XCTAssertEqual(Math.tan(Double.pi / 4), 1.0, accuracy: 0.0001)
  }

  func testLogarithm() {
    // Test log
    XCTAssertEqual(Math.log(1.0), 0.0, accuracy: 0.0001)
    XCTAssertEqual(Math.log(Math.E), 1.0, accuracy: 0.0001)
  }

  func testConstants() {
    // Test PI
    XCTAssertEqual(Math.PI, Double.pi)

    // Test E
    XCTAssertEqual(Math.E, Darwin.M_E)
  }
}
