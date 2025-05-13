import Foundation

extension String {
  // 模拟 JavaScript 的 encodeURI()
  func encodeURI() -> String? {
    // 定义 encodeURI 保留的字符集
    let allowedCharacters = CharacterSet(
      charactersIn:
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;,/?:@&=+$-_.!~*'()#")
    return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
  }

  // 模拟 JavaScript 的 encodeURIComponent()
  func encodeURIComponent() -> String? {
    // 定义 encodeURIComponent 保留的字符集
    let allowedCharacters = CharacterSet(
      charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.!~*'()")
    return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
  }

  // 模拟 JavaScript 的 decodeURI()
  func decodeURI() throws -> String {
    guard let decoded = self.removingPercentEncoding else {
      throw URLError.invalidEncoding("Invalid URI encoding")
    }

    // 验证解码后的字符串是否可以重新编码为相同的 URI
    if let reEncoded = decoded.encodeURI(), reEncoded == self {
      return decoded
    } else {
      throw URLError.invalidEncoding("Decoded string contains characters not valid in URI")
    }
  }

  // 模拟 JavaScript 的 decodeURIComponent()
  func decodeURIComponent() throws -> String {
    guard let decoded = self.removingPercentEncoding else {
      throw URLError.invalidEncoding("Invalid URI component encoding")
    }
    return decoded
  }

  enum URLError: Error {
    case invalidEncoding(String)

    var localizedDescription: String {
      switch self {
      case .invalidEncoding(let message):
        return message
      }
    }
  }
}
