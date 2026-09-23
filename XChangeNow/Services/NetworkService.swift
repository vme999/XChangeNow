import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError
    case unknown(Error)
}

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = APIConfig.baseURL // 使用 APIConfig 中的配置
    private let apiKey = APIConfig.apiKey
    
    func fetch<T: Decodable>(_ endpoint: String) async throws -> T {
        // 构建完整的 URL，包含 API Key
        let fullEndpoint = "\(baseURL)/\(apiKey)\(endpoint)"
        guard let url = URL(string: fullEndpoint) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // 打印请求的 URL
        print("Request URL: \(url.absoluteString)")
            
        // 检查并打印响应
        if let httpResponse = response as? HTTPURLResponse {
            print("Response Status Code: \(httpResponse.statusCode)")
            print("Response Headers: \(httpResponse.allHeaderFields)")
        }
                
        // 打印响应数据
        if let responseData = String(data: data, encoding: .utf8) {
            print("Response Data: \(responseData)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}
