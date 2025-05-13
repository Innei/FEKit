//
//  Date.swift
//  FEKit
//
//  Date utilities inspired by JavaScript's Date object
//

import Foundation

/// JSDate: A class representing a JavaScript-like Date object
class JSDate {
  private var date: Foundation.Date

  /// Creates a new Date object representing the current time
  public init() {
    self.date = Foundation.Date()
  }

  /// Creates a new Date object with the specified number of milliseconds since Jan 1, 1970, 00:00:00 UTC
  /// - Parameter milliseconds: The number of milliseconds since Jan 1, 1970, 00:00:00 UTC
  public init(milliseconds: TimeInterval) {
    self.date = Foundation.Date(timeIntervalSince1970: milliseconds / 1000)
  }

  /// Creates a new Date object from a date string
  /// - Parameter dateString: A string representing a date
  public init?(dateString: String) {
    guard let timeInterval = Date.parse(dateString) else {
      return nil
    }
    self.date = Foundation.Date(timeIntervalSince1970: timeInterval / 1000)
  }

  /// Creates a new Date object with the specified date components
  /// - Parameters:
  ///   - year: The year (e.g. 2022)
  ///   - month: The month (0-11, where 0 = January)
  ///   - day: The day of the month (1-31)
  ///   - hours: The hour (0-23)
  ///   - minutes: The minute (0-59)
  ///   - seconds: The second (0-59)
  ///   - milliseconds: The milliseconds (0-999)
  public init(
    year: Int, month: Int, day: Int = 1, hours: Int = 0, minutes: Int = 0, seconds: Int = 0,
    milliseconds: Int = 0
  ) {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month + 1  // JavaScript months are 0-based
    dateComponents.day = day
    dateComponents.hour = hours
    dateComponents.minute = minutes
    dateComponents.second = seconds
    dateComponents.nanosecond = milliseconds * 1_000_000

    let calendar = Calendar(identifier: .gregorian)
    self.date = calendar.date(from: dateComponents) ?? Foundation.Date()
  }

  // MARK: - Getters

  /// Gets the year
  /// - Returns: The year (e.g. 2022)
  public func getFullYear() -> Int {
    return Calendar.current.component(.year, from: date)
  }

  /// Gets the month
  /// - Returns: The month (0-11, where 0 = January)
  public func getMonth() -> Int {
    return Calendar.current.component(.month, from: date) - 1  // Convert to 0-based
  }

  /// Gets the day of the month
  /// - Returns: The day of the month (1-31)
  public func getDate() -> Int {
    return Calendar.current.component(.day, from: date)
  }

  /// Gets the day of the week
  /// - Returns: The day of the week (0-6, where 0 = Sunday)
  public func getDay() -> Int {
    let weekday = Calendar.current.component(.weekday, from: date)
    return weekday - 1  // Convert from 1-based to 0-based, where 1 = Sunday
  }

  /// Gets the hour
  /// - Returns: The hour (0-23)
  public func getHours() -> Int {
    return Calendar.current.component(.hour, from: date)
  }

  /// Gets the minute
  /// - Returns: The minute (0-59)
  public func getMinutes() -> Int {
    return Calendar.current.component(.minute, from: date)
  }

  /// Gets the second
  /// - Returns: The second (0-59)
  public func getSeconds() -> Int {
    return Calendar.current.component(.second, from: date)
  }

  /// Gets the milliseconds
  /// - Returns: The millisecond (0-999)
  public func getMilliseconds() -> Int {
    return Calendar.current.component(.nanosecond, from: date) / 1_000_000
  }

  /// Gets the time value in milliseconds
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  public func getTime() -> TimeInterval {
    return date.timeIntervalSince1970 * 1000
  }

  /// Gets the timezone offset in minutes
  /// - Returns: The timezone offset in minutes
  public func getTimezoneOffset() -> Int {
    return TimeZone.current.secondsFromGMT() / 60 * -1  // JavaScript returns the offset with opposite sign
  }

  // MARK: - UTC Getters

  /// Gets the UTC year
  /// - Returns: The UTC year (e.g. 2022)
  public func getUTCFullYear() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    var calendarUTC = calendar
    calendarUTC.timeZone = TimeZone(abbreviation: "UTC")!
    return calendarUTC.component(.year, from: date)
  }

  /// Gets the UTC month
  /// - Returns: The UTC month (0-11, where 0 = January)
  public func getUTCMonth() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    var calendarUTC = calendar
    calendarUTC.timeZone = TimeZone(abbreviation: "UTC")!
    return calendarUTC.component(.month, from: date) - 1  // Convert to 0-based
  }

  /// Gets the UTC day of the month
  /// - Returns: The UTC day of the month (1-31)
  public func getUTCDate() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    var calendarUTC = calendar
    calendarUTC.timeZone = TimeZone(abbreviation: "UTC")!
    return calendarUTC.component(.day, from: date)
  }

  /// Gets the UTC day of the week
  /// - Returns: The UTC day of the week (0-6, where 0 = Sunday)
  public func getUTCDay() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    var calendarUTC = calendar
    calendarUTC.timeZone = TimeZone(abbreviation: "UTC")!
    let weekday = calendarUTC.component(.weekday, from: date)
    return weekday - 1  // Convert from 1-based to 0-based, where 1 = Sunday
  }

  /// Gets the UTC hour
  /// - Returns: The UTC hour (0-23)
  public func getUTCHours() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    var calendarUTC = calendar
    calendarUTC.timeZone = TimeZone(abbreviation: "UTC")!
    return calendarUTC.component(.hour, from: date)
  }

  /// Gets the UTC minute
  /// - Returns: The UTC minute (0-59)
  public func getUTCMinutes() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    var calendarUTC = calendar
    calendarUTC.timeZone = TimeZone(abbreviation: "UTC")!
    return calendarUTC.component(.minute, from: date)
  }

  /// Gets the UTC second
  /// - Returns: The UTC second (0-59)
  public func getUTCSeconds() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    var calendarUTC = calendar
    calendarUTC.timeZone = TimeZone(abbreviation: "UTC")!
    return calendarUTC.component(.second, from: date)
  }

  /// Gets the UTC milliseconds
  /// - Returns: The UTC millisecond (0-999)
  public func getUTCMilliseconds() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    var calendarUTC = calendar
    calendarUTC.timeZone = TimeZone(abbreviation: "UTC")!
    return calendarUTC.component(.nanosecond, from: date) / 1_000_000
  }

  // MARK: - Setters

  /// Sets the year
  /// - Parameter year: The year (e.g. 2022)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setFullYear(_ year: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone.current
    date = calendar.date(bySetting: .year, value: year, of: date) ?? date
    return getTime()
  }

  /// Sets the month
  /// - Parameter month: The month (0-11, where 0 = January)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setMonth(_ month: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone.current
    date = calendar.date(bySetting: .month, value: month + 1, of: date) ?? date
    return getTime()
  }

  /// Sets the day of the month
  /// - Parameter day: The day of the month (1-31)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setDate(_ day: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone.current
    date = calendar.date(bySetting: .day, value: day, of: date) ?? date
    return getTime()
  }

  /// Sets the hour
  /// - Parameter hours: The hour (0-23)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setHours(_ hours: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone.current
    date = calendar.date(bySetting: .hour, value: hours, of: date) ?? date
    return getTime()
  }

  /// Sets the minute
  /// - Parameter minutes: The minute (0-59)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setMinutes(_ minutes: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone.current
    date = calendar.date(bySetting: .minute, value: minutes, of: date) ?? date
    return getTime()
  }

  /// Sets the second
  /// - Parameter seconds: The second (0-59)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setSeconds(_ seconds: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone.current
    date = calendar.date(bySetting: .second, value: seconds, of: date) ?? date
    return getTime()
  }

  /// Sets the millisecond
  /// - Parameter milliseconds: The millisecond (0-999)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setMilliseconds(_ milliseconds: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone.current
    date = calendar.date(bySetting: .nanosecond, value: milliseconds * 1_000_000, of: date) ?? date
    return getTime()
  }

  /// Sets the time
  /// - Parameter milliseconds: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setTime(_ milliseconds: TimeInterval) -> TimeInterval {
    date = Foundation.Date(timeIntervalSince1970: milliseconds / 1000)
    return getTime()
  }

  // MARK: - UTC Setters

  /// Sets the UTC year
  /// - Parameter year: The UTC year (e.g. 2022)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setUTCFullYear(_ year: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(abbreviation: "UTC")!
    date = calendar.date(bySetting: .year, value: year, of: date) ?? date
    return getTime()
  }

  /// Sets the UTC month
  /// - Parameter month: The UTC month (0-11, where 0 = January)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setUTCMonth(_ month: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(abbreviation: "UTC")!
    date = calendar.date(bySetting: .month, value: month + 1, of: date) ?? date
    return getTime()
  }

  /// Sets the UTC day of the month
  /// - Parameter day: The UTC day of the month (1-31)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setUTCDate(_ day: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(abbreviation: "UTC")!
    date = calendar.date(bySetting: .day, value: day, of: date) ?? date
    return getTime()
  }

  /// Sets the UTC hour
  /// - Parameter hours: The UTC hour (0-23)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setUTCHours(_ hours: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(abbreviation: "UTC")!
    date = calendar.date(bySetting: .hour, value: hours, of: date) ?? date
    return getTime()
  }

  /// Sets the UTC minute
  /// - Parameter minutes: The UTC minute (0-59)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setUTCMinutes(_ minutes: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(abbreviation: "UTC")!
    date = calendar.date(bySetting: .minute, value: minutes, of: date) ?? date
    return getTime()
  }

  /// Sets the UTC second
  /// - Parameter seconds: The UTC second (0-59)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setUTCSeconds(_ seconds: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(abbreviation: "UTC")!
    date = calendar.date(bySetting: .second, value: seconds, of: date) ?? date
    return getTime()
  }

  /// Sets the UTC millisecond
  /// - Parameter milliseconds: The UTC millisecond (0-999)
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  @discardableResult
  public func setUTCMilliseconds(_ milliseconds: Int) -> TimeInterval {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(abbreviation: "UTC")!
    date = calendar.date(bySetting: .nanosecond, value: milliseconds * 1_000_000, of: date) ?? date
    return getTime()
  }

  // MARK: - String Conversion Methods

  /// Converts the date to a string using the local time zone
  /// - Returns: A string representation of the date
  public func toString() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .long
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter.string(from: date)
  }

  /// Converts the date to a string using the browser's time zone
  /// - Returns: A string representation of the date
  public func toDateString() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter.string(from: date)
  }

  /// Converts the time portion of the date to a string using the browser's time zone
  /// - Returns: A string representation of the time
  public func toTimeString() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .long
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter.string(from: date)
  }

  /// Converts the date to a string using the ISO 8601 standard
  /// - Returns: A string representation of the date in ISO format
  public func toISOString() -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter.string(from: date)
  }

  /// Converts the date to a string using UTC time zone
  /// - Returns: A string representation of the date in UTC
  public func toUTCString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss 'GMT'"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter.string(from: date)
  }

  /// Converts the date to a JSON-compatible string
  /// - Returns: A JSON-compatible string representation of the date
  public func toJSON() -> String {
    return toISOString()
  }
}

/// Date utilities that mimic JavaScript's Date object functionality
extension Date {

  /// Returns the number of milliseconds elapsed since January 1, 1970 00:00:00 UTC
  public static func now() -> TimeInterval {
    return Foundation.Date().timeIntervalSince1970 * 1000
  }

  /// Parses a date string and returns the number of milliseconds since January 1, 1970, 00:00:00 UTC
  /// - Parameter dateString: A string representing a date
  /// - Returns: The number of milliseconds since January 1, 1970, 00:00:00 UTC
  public static func parse(_ dateString: String) -> TimeInterval? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

    // Try ISO 8601 format first
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    if let date = dateFormatter.date(from: dateString) {
      return date.timeIntervalSince1970 * 1000
    }

    // Try other common formats
    let formats = [
      "yyyy-MM-dd",
      "yyyy/MM/dd",
      "MM/dd/yyyy",
      "MMMM d, yyyy",
      "MMM d, yyyy",
      "d MMMM yyyy",
      "yyyy-MM-dd'T'HH:mm:ssZ",
    ]

    for format in formats {
      dateFormatter.dateFormat = format
      if let date = dateFormatter.date(from: dateString) {
        return date.timeIntervalSince1970 * 1000
      }
    }

    // If all else fails, try Foundation's date parsing
    let formatter = ISO8601DateFormatter()
    if let date = formatter.date(from: dateString) {
      return date.timeIntervalSince1970 * 1000
    }

    return nil
  }

  /// Returns the number of milliseconds in a time string
  /// - Parameter timeString: A string representing time (e.g. "01:02:03.456")
  /// - Returns: The number of milliseconds
  public static func UTC(
    _ year: Int, _ month: Int, _ day: Int = 1, _ hours: Int = 0, _ minutes: Int = 0,
    _ seconds: Int = 0, _ milliseconds: Int = 0
  ) -> TimeInterval {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month + 1  // JavaScript months are 0-based
    dateComponents.day = day
    dateComponents.hour = hours
    dateComponents.minute = minutes
    dateComponents.second = seconds
    dateComponents.nanosecond = milliseconds * 1_000_000
    dateComponents.timeZone = TimeZone(abbreviation: "UTC")

    let calendar = Calendar(identifier: .gregorian)
    if let date = calendar.date(from: dateComponents) {
      return date.timeIntervalSince1970 * 1000
    }
    return 0
  }
}
