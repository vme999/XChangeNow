import Foundation

class ExchangeRateService {
    private let networkService: NetworkService
    private var cachedRates: [String: [String: Double]] = [:]
    private var lastUpdateTime: [String: Date] = [:]
    private let cacheValidityDuration: TimeInterval = 30 * 60 // 30分钟缓存URLSession
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func getExchangeRate(from: Currency, to: Currency) async throws -> Double {
        // 检查缓存是否有效
        if let rate = getCachedRate(from: from.id, to: to.id) {
            return rate
        }
        
        // 获取最新汇率
        // 使用 APIConfig 中定义的 endpoint
        let endpoint = APIConfig.Endpoints.latestRates(base: from.id)
        let response: ExchangeRateResponse = try await networkService.fetch(endpoint)
        
        // 更新缓存
        updateCache(base: from.id, rates: response.conversion_rates)
        
        guard let rate = response.conversion_rates[to.id] else {
            throw ExchangeError.rateNotFound
        }
        
        return rate
    }
    
    func convert(amount: Double, from: Currency, to: Currency) async throws -> ExchangeResult {
        let rate = try await getExchangeRate(from: from, to: to)
        let convertedAmount = amount * rate
        
        return ExchangeResult(
            fromAmount: amount,
            toAmount: convertedAmount,
            rate: rate,
            fromCurrency: from,
            toCurrency: to,
            timestamp: Date()
        )
    }
    
    // MARK: - Private Methods
    
    private func getCachedRate(from: String, to: String) -> Double? {
        guard let lastUpdate = lastUpdateTime[from],
              let rates = cachedRates[from],
              let rate = rates[to],
              Date().timeIntervalSince(lastUpdate) < cacheValidityDuration else {
            return nil
        }
        return rate
    }
    
    private func updateCache(base: String, rates: [String: Double]) {
        cachedRates[base] = rates
        lastUpdateTime[base] = Date()
    }
}

// 错误类型
enum ExchangeError: LocalizedError {
    case rateNotFound
    case invalidAmount
    
    var errorDescription: String? {
        switch self {
        case .rateNotFound:
            return "找不到对应的汇率信息"
        case .invalidAmount:
            return "请输入有效的金额"
        }
    }
}
