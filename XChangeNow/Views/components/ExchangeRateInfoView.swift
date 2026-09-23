import SwiftUI

struct ExchangeRateInfoView: View {
    let rateText: String
    let updateTimeText: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(rateText)
                .font(.subheadline)
            Text(updateTimeText)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
