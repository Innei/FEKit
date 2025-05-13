import XCTest

@testable import FEKit

final class NumberTests: XCTestCase {
  func testFixed() {
    XCTAssertEqual(Number.toFixed(123.456), "123.46")
    XCTAssertEqual(Number.toFixed(123.456, digits: 1), "123.5")
    XCTAssertEqual(Number.toFixed(123.456, digits: 2), "123.46")
  }
}
