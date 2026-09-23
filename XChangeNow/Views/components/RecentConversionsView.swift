import SwiftUI

struct RecentConversionsView: View {
    let conversions: [ExchangeResult]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("最近转换")
                .font(.headline)
                .foregroundColor(.secondary)
            
            ForEach(conversions, id: \.timestamp) { result in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(result.fromAmount, format: .currency(code: result.fromCurrency.id))
                        Text("→")
                        Text(result.toAmount, format: .currency(code: result.toCurrency.id))
                        Spacer()
                        Text(result.timestamp, style: .time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("汇率: \(result.rate, specifier: "%.4f")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
        .padding()
    }
}
