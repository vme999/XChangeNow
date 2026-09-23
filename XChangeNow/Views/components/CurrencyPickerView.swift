import SwiftUI

struct CurrencyPickerView: View {
    @Binding var selectedCurrency: Currency
    let currencies: [Currency]
    
    var body: some View {
        HStack {
            Image(selectedCurrency.id.lowercased())
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            
            Picker("选择货币", selection: $selectedCurrency) {
                ForEach(currencies) { currency in
                    HStack {
                        Text(currency.id)
                            .foregroundColor(.primary)
                        Text(currency.name)
                            .foregroundColor(.secondary)
                    }
                    .tag(currency)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .accentColor(.primary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}
