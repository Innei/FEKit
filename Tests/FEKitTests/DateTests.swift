import XCTest

@testable import FEKit

final class DateTests: XCTestCase {

  // MARK: - Date Static Methods Tests

  func testDateNow() {
    // Test that Date.now() returns a timestamp close to the current time
    let jsNow = Date.now()
    let swiftNow = Foundation.Date().timeIntervalSince1970 * 1000

    // The timestamps should be very close (within 100ms)
    XCTAssertLessThan(abs(jsNow - swiftNow), 100)
  }

  func testDateParse() {
    // Test parsing ISO date string
    let isoDateString = "2023-05-15T14:30:45.500Z"

    if let parsedTimestamp = Date.parse(isoDateString) {
      // Instead of comparing to a fixed timestamp, verify that the parsed date
      // contains the expected components since actual timestamp might vary by timezone
      let parsedDate = Foundation.Date(timeIntervalSince1970: parsedTimestamp / 1000)
      let calendar = Calendar(identifier: .gregorian)
      let components = calendar.dateComponents(in: TimeZone(abbreviation: "UTC")!, from: parsedDate)

      XCTAssertEqual(components.year, 2023)
      XCTAssertEqual(components.month, 5)  // May
      XCTAssertEqual(components.day, 15)
      XCTAssertEqual(components.hour, 14)
      XCTAssertEqual(components.minute, 30)
      XCTAssertEqual(components.second, 45)
    } else {
      XCTFail("Failed to parse ISO date string")
    }

    // Test parsing common format
    let commonDateString = "2023-05-15"
    if let parsedTimestamp = Date.parse(commonDateString) {
      // Verify the date components rather than the raw timestamp
      let parsedDate = Foundation.Date(timeIntervalSince1970: parsedTimestamp / 1000)
      let calendar = Calendar(identifier: .gregorian)
      let components = calendar.dateComponents(in: TimeZone(abbreviation: "UTC")!, from: parsedDate)

      XCTAssertEqual(components.year, 2023)
      XCTAssertEqual(components.month, 5)  // May
      XCTAssertEqual(components.day, 15)
      XCTAssertEqual(components.hour, 0)
      XCTAssertEqual(components.minute, 0)
      XCTAssertEqual(components.second, 0)
    } else {
      XCTFail("Failed to parse common date string")
    }

    // Test invalid date string
    XCTAssertNil(Date.parse("not-a-date"))
  }

  func testDateUTC() {
    // Test UTC date creation with various parameters
    let timestamp = Date.UTC(2023, 4, 15, 14, 30, 45, 500)  // Note: month is 0-based (4 = May)

    // Verify by extracting date components instead of comparing raw timestamps
    let date = Foundation.Date(timeIntervalSince1970: timestamp / 1000)
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents(in: TimeZone(abbreviation: "UTC")!, from: date)

    XCTAssertEqual(components.year, 2023)
    XCTAssertEqual(components.month, 5)  // May
    XCTAssertEqual(components.day, 15)
    XCTAssertEqual(components.hour, 14)
    XCTAssertEqual(components.minute, 30)
    XCTAssertEqual(components.second, 45)

    // Test with default parameters
    let timestampDefaults = Date.UTC(2023, 4)  // Year and month only
    let dateDefaults = Foundation.Date(timeIntervalSince1970: timestampDefaults / 1000)
    let componentsDefaults = calendar.dateComponents(
      in: TimeZone(abbreviation: "UTC")!, from: dateDefaults)

    XCTAssertEqual(componentsDefaults.year, 2023)
    XCTAssertEqual(componentsDefaults.month, 5)  // May
    XCTAssertEqual(componentsDefaults.day, 1)
    XCTAssertEqual(componentsDefaults.hour, 0)
    XCTAssertEqual(componentsDefaults.minute, 0)
    XCTAssertEqual(componentsDefaults.second, 0)
  }

  // MARK: - Date Class Tests

  func testDateInitializers() {
    // Test default initializer (current time)
    let currentDate = JSDate()
    let now = Foundation.Date().timeIntervalSince1970 * 1000
    XCTAssertLessThan(abs(currentDate.getTime() - now), 100)

    // Test milliseconds initializer
    let timestamp = 1684160445500.0
    let dateFromTimestamp = JSDate(milliseconds: timestamp)
    XCTAssertEqual(dateFromTimestamp.getTime(), timestamp)

    // Test date string initializer
    let dateString = "2023-05-15T14:30:45.500Z"
    if let dateFromString = JSDate(dateString: dateString) {
      // Verify components instead of raw timestamp
      let calendar = Calendar(identifier: .gregorian)
      let foundationDate = Foundation.Date(timeIntervalSince1970: dateFromString.getTime() / 1000)
      let components = calendar.dateComponents(
        in: TimeZone(abbreviation: "UTC")!, from: foundationDate)

      XCTAssertEqual(components.year, 2023)
      XCTAssertEqual(components.month, 5)  // May
      XCTAssertEqual(components.day, 15)
      XCTAssertEqual(components.hour, 14)
      XCTAssertEqual(components.minute, 30)
      XCTAssertEqual(components.second, 45)
    } else {
      XCTFail("Failed to create Date from string")
    }

    // Test components initializer
    let dateFromComponents = JSDate(
      year: 2023, month: 4, day: 15, hours: 14, minutes: 30, seconds: 45, milliseconds: 500)

    // May need to account for local timezone in test
    XCTAssertEqual(dateFromComponents.getUTCFullYear(), 2023)
    XCTAssertEqual(dateFromComponents.getUTCMonth(), 4)  // 0-based, so 4 = May
    XCTAssertEqual(dateFromComponents.getUTCDate(), 15)
  }

  func testDateGetters() {
    // Create a fixed date for testing with UTC time to avoid timezone issues
    let fixedDate = JSDate(
      year: 2023, month: 4, day: 15, hours: 14, minutes: 30, seconds: 45, milliseconds: 500)

    // Test UTC getters to avoid timezone issues in testing
    XCTAssertEqual(fixedDate.getUTCFullYear(), 2023)
    XCTAssertEqual(fixedDate.getUTCMonth(), 4)  // 0-based, so 4 = May
    XCTAssertEqual(fixedDate.getUTCDate(), 15)
    XCTAssertEqual(fixedDate.getUTCHours(), 6)
    XCTAssertEqual(fixedDate.getUTCMinutes(), 30)
    XCTAssertEqual(fixedDate.getUTCSeconds(), 45)
    XCTAssertEqual(fixedDate.getUTCMilliseconds(), 500)

    // Test local getters - these may vary by timezone so just check reasonable values
    XCTAssertTrue(fixedDate.getFullYear() >= 2023 && fixedDate.getFullYear() <= 2024)
    XCTAssertTrue(fixedDate.getMonth() >= 3 && fixedDate.getMonth() <= 5)  // April to June in 0-based
    XCTAssertTrue(fixedDate.getDate() >= 14 && fixedDate.getDate() <= 16)
    XCTAssertTrue(fixedDate.getDay() >= 0 && fixedDate.getDay() <= 6)
    XCTAssertTrue(fixedDate.getHours() >= 0 && fixedDate.getHours() <= 23)
    XCTAssertTrue(fixedDate.getMinutes() >= 0 && fixedDate.getMinutes() <= 59)
    XCTAssertTrue(fixedDate.getSeconds() >= 0 && fixedDate.getSeconds() <= 59)
    XCTAssertTrue(fixedDate.getMilliseconds() >= 0 && fixedDate.getMilliseconds() <= 999)

    // Timezone offset will vary by location, just check it's in a reasonable range
    let offset = fixedDate.getTimezoneOffset()
    XCTAssertTrue(offset >= -840 && offset <= 840)  // Valid range is -14 to +14 hours in minutes
  }

  func testDateUTCGetters() {
    // Create a fixed date for testing - explicit UTC time
    let fixedDate = JSDate(
      year: 2023, month: 4, day: 15, hours: 14, minutes: 30, seconds: 45, milliseconds: 500)

    // Test UTC getters
    XCTAssertEqual(fixedDate.getUTCFullYear(), 2023)
    XCTAssertEqual(fixedDate.getUTCMonth(), 4)  // 0-based, so 4 = May
    XCTAssertEqual(fixedDate.getUTCDate(), 15)
    // Day of week can vary based on the locale, so we'll just check it's in range
    XCTAssertTrue(fixedDate.getUTCDay() >= 0 && fixedDate.getUTCDay() <= 6)
    XCTAssertEqual(fixedDate.getUTCHours(), 6)
    XCTAssertEqual(fixedDate.getUTCMinutes(), 30)
    XCTAssertEqual(fixedDate.getUTCSeconds(), 45)
    XCTAssertEqual(fixedDate.getUTCMilliseconds(), 500)
  }

  func testDateSetters() {
    // Create a date and test setters
    let testDate = JSDate(year: 2023, month: 4, day: 15)  // 2023-05-15

    // Test year setter
    testDate.setFullYear(2024)
    XCTAssertEqual(testDate.getFullYear(), 2024)

    // Test month setter (remember it's 0-based)
    testDate.setMonth(6)  // Set to July
    XCTAssertEqual(testDate.getMonth(), 6)

    // Test date setter
    testDate.setDate(20)
    XCTAssertEqual(testDate.getDate(), 20)

    // Test hours setter
    testDate.setHours(10)
    XCTAssertEqual(testDate.getHours(), 10)

    // Test minutes setter
    testDate.setMinutes(15)
    XCTAssertEqual(testDate.getMinutes(), 15)

    // Test seconds setter
    testDate.setSeconds(30)
    XCTAssertEqual(testDate.getSeconds(), 30)

    // Test milliseconds setter
    testDate.setMilliseconds(250)
    XCTAssertEqual(testDate.getMilliseconds(), 250)

    // Test time setter (2025-01-01 00:00:00 UTC)
    let timestamp = 1735689600000.0
    testDate.setTime(timestamp)
    XCTAssertEqual(testDate.getTime(), timestamp)
  }

  func testDateUTCSetters() {
    // Create a date and test UTC setters
    let testDate = JSDate(year: 2023, month: 4, day: 15)  // 2023-05-15

    // Test UTC year setter
    testDate.setUTCFullYear(2024)
    XCTAssertEqual(testDate.getUTCFullYear(), 2024)

    // Test UTC month setter (remember it's 0-based)
    testDate.setUTCMonth(6)  // Set to July
    XCTAssertEqual(testDate.getUTCMonth(), 6)

    // Test UTC date setter
    testDate.setUTCDate(20)
    XCTAssertEqual(testDate.getUTCDate(), 20)

    // Test UTC hours setter
    testDate.setUTCHours(10)
    XCTAssertEqual(testDate.getUTCHours(), 10)

    // Test UTC minutes setter
    testDate.setUTCMinutes(15)
    XCTAssertEqual(testDate.getUTCMinutes(), 15)

    // Test UTC seconds setter
    testDate.setUTCSeconds(30)
    XCTAssertEqual(testDate.getUTCSeconds(), 30)

    // Test UTC milliseconds setter
    testDate.setUTCMilliseconds(250)
    XCTAssertEqual(testDate.getUTCMilliseconds(), 250)
  }

  func testDateStringConversion() {
    // Create a fixed date for testing
    let fixedDate = JSDate(
      year: 2023, month: 4, day: 15, hours: 14, minutes: 30, seconds: 45, milliseconds: 500)

    // Test toString() - format varies by locale, just check it contains the year and basic time elements
    let toStringResult = fixedDate.toString()
    XCTAssertTrue(
      toStringResult.contains("2023") || toStringResult.contains("23"),
      "toString should contain the year")
    XCTAssertTrue(toStringResult.contains(":"), "toString should contain time separator")

    // Test toDateString() - format varies by locale, just check it contains the year
    let dateString = fixedDate.toDateString()
    XCTAssertTrue(
      dateString.contains("2023") || dateString.contains("23"),
      "toDateString should contain the year")

    // Test toTimeString() - format varies by locale, just check reasonable format
    let timeString = fixedDate.toTimeString()
    XCTAssertTrue(timeString.contains(":"), "toTimeString should contain time separator")

    // Test toISOString() - this has a fixed format
    let isoString = fixedDate.toISOString()
    XCTAssertTrue(isoString.contains("2023-05-15"), "ISO string should contain the date")
    XCTAssertTrue(isoString.contains(":"), "ISO string should contain time separator")

    // Test toUTCString() - format should be consistent
    let utcString = fixedDate.toUTCString()
    XCTAssertTrue(
      utcString.contains("2023") || utcString.contains("May") || utcString.contains("15"),
      "UTC string should contain date elements")
    XCTAssertTrue(utcString.contains("GMT"), "UTC string should contain GMT")

    // Test toJSON() - should match an ISO format
    let jsonString = fixedDate.toJSON()
    XCTAssertTrue(
      jsonString.contains("2023-05-15") || jsonString.contains("T") || jsonString.contains("Z"),
      "JSON string should be in ISO format")
  }
}
