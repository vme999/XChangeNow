import SwiftUI

struct ExchangeResultView: View {
    let amount: Double
    let currency: Currency
    let isLoading: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            if isLoading {
                ProgressView()
            } else {
                Text(amount, format: .currency(code: currency.id))
                    .font(.system(size: 42, weight: .bold))
                
                Text("\(currency.name) (\(currency.symbol))")
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}
