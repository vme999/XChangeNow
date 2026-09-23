import Foundation

enum PreviewData {
    static let sampleCurrencies = Currency.common
    
    static let sampleExchangeResult = ExchangeResult(
        fromAmount: 100,
        toAmount: 723.45,
        rate: 7.2345,
        fromCurrency: Currency.common[0],
        toCurrency: Currency.common[1],
        timestamp: Date()
    )
    
    static let sampleRecentConversions = [
        sampleExchangeResult,
        ExchangeResult(
            fromAmount: 50,
            toAmount: 361.725,
            rate: 7.2345,
            fromCurrency: Currency.common[0],
            toCurrency: Currency.common[1],
            timestamp: Date().addingTimeInterval(-3600)
        )
    ]
} 