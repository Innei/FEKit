import Darwin

public enum Math {
  /// Returns a random number between 0 (inclusive) and 1 (exclusive)
  public static func random() -> Double {
    return Double.random(in: 0..<1)
  }

  /// Returns a random integer between min (inclusive) and max (exclusive)
  public static func random(min: Int, max: Int) -> Int {
    return Int.random(in: min..<max)
  }

  /// Returns a random integer between min (inclusive) and max (inclusive)
  public static func randomInt(min: Int, max: Int) -> Int {
    return Int.random(in: min...max)
  }

  /// Rounds a number to the nearest integer
  /// In JavaScript, Math.round(-3.5) is -3, not -4
  public static func round(_ x: Double) -> Int {
    // JavaScript rounds toward positive infinity for tie-breaking with negative numbers
    // While Swift's round() rounds to the nearest even integer (banker's rounding)
    if x < 0 && x.truncatingRemainder(dividingBy: 1) == -0.5 {
      return Int(Darwin.ceil(x))
    }
    return Int(Darwin.round(x))
  }

  /// Returns the largest integer less than or equal to a number
  public static func floor(_ x: Double) -> Int {
    return Int(Darwin.floor(x))
  }

  /// Returns the smallest integer greater than or equal to a number
  public static func ceil(_ x: Double) -> Int {
    return Int(Darwin.ceil(x))
  }

  /// Returns the absolute value of a number
  public static func abs(_ x: Double) -> Double {
    return Swift.abs(x)
  }

  /// Returns the minimum of two numbers
  public static func min(_ x: Double, _ y: Double) -> Double {
    return Swift.min(x, y)
  }

  /// Returns the maximum of two numbers
  public static func max(_ x: Double, _ y: Double) -> Double {
    return Swift.max(x, y)
  }

  /// Returns base to the power of exponent
  public static func pow(_ base: Double, _ exponent: Double) -> Double {
    return Darwin.pow(base, exponent)
  }

  /// Returns the square root of a number
  public static func sqrt(_ x: Double) -> Double {
    return Darwin.sqrt(x)
  }

  /// Returns trigonometric sine of an angle in radians
  public static func sin(_ x: Double) -> Double {
    return Darwin.sin(x)
  }

  /// Returns trigonometric cosine of an angle in radians
  public static func cos(_ x: Double) -> Double {
    return Darwin.cos(x)
  }

  /// Returns trigonometric tangent of an angle in radians
  public static func tan(_ x: Double) -> Double {
    return Darwin.tan(x)
  }

  /// Returns the natural logarithm (base e) of a number
  public static func log(_ x: Double) -> Double {
    return Darwin.log(x)
  }

  /// Returns a value truncated to a given precision
  public static func trunc(_ x: Double) -> Double {
    return Darwin.trunc(x)
  }

  // Constants
  public static let PI: Double = Double.pi
  public static let E: Double = Darwin.M_E
}
