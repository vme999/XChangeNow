import Foundation

struct ExchangeRateResponse: Codable {
    let result: String
    let documentation: String
    let terms_of_use: String
    let time_last_update_unix: Int
    let time_last_update_utc: String
    let time_next_update_unix: Int
    let time_next_update_utc: String
    let base_code: String
    let conversion_rates: [String: Double]
}


struct ExchangeResult: Codable, Identifiable {
    let id: UUID
    let fromAmount: Double
    let toAmount: Double
    let rate: Double
    let fromCurrency: Currency
    let toCurrency: Currency
    let timestamp: Date
    
    init(fromAmount: Double, toAmount: Double, rate: Double, fromCurrency: Currency, toCurrency: Currency, timestamp: Date = Date()) {
        self.id = UUID()
        self.fromAmount = fromAmount
        self.toAmount = toAmount
        self.rate = rate
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.timestamp = timestamp
    }
}
