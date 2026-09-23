import Foundation

enum APIConfig {
    static let baseURL = "https://v6.exchangerate-api.com/v6"
    static let apiKey = "d139569de019878df6dcb21b" // 在实际使用时替换为真实的 API key
    
    enum Endpoints {
        static func latestRates(base: String) -> String {
            return "/latest/\(base)"
        }
    }
    
    static let headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
}
