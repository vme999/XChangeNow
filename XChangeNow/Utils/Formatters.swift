import Foundation

enum Formatters {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func formatCurrency(_ amount: Double, code: String) -> String {
        currencyFormatter.currencyCode = code
        return currencyFormatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
    
    static func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
