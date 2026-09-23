import SwiftUI

struct AmountInputView: View {
    let title: String
    @Binding var amount: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.secondary)
                .font(.subheadline)
            
            TextField("0.00", value: $amount, format: .number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .font(.system(size: 34, weight: .medium))
        }
        .padding(.horizontal)
    }
}
