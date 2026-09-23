import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ExchangeViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            // 货币列表
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(0..<Currency.common.count, id: \.self) { index in
                        CurrencyRow(
                            currency: Currency.common[index],
                            amount: index < viewModel.convertedAmounts.count ? viewModel.convertedAmounts[index] : 0.0,
                            isSelected: index == viewModel.selectedCurrencyIndex,
                            onSelect: {
                                viewModel.selectedCurrencyIndex = index  // 更新选中的货币
                                viewModel.clear()
                            }
                        )
                    }
                }
                .padding()
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.6)
                        
            // 数字键盘
            CalculatorKeypad(viewModel: viewModel)
                .padding(.vertical, 8)
        }
    }
}

struct CurrencyRow: View {
    let currency: Currency
    let amount: Double
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
            HStack {
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    onSelect()
                }) {
                    HStack {
                        Text(currency.flag)
                        Text(currency.id)
                    }
                    .frame(width: 80)
                }
                .buttonStyle(.bordered)
                .tint(isSelected ? .blue : .gray)
                
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    onSelect()
                }) {
                    TextField("0.00", value: .constant(amount), format: .number.precision(.fractionLength(0...3)))
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.trailing)
                        .disabled(true)
                }
            }
    }
}

struct CalculatorKeypad: View {
    @ObservedObject var viewModel: ExchangeViewModel
    
    let buttons: [[CalculatorButton]] = [
        [.number("7"), .number("8"), .number("9"), .operator("÷")],
        [.number("4"), .number("5"), .number("6"), .operator("×")],
        [.number("1"), .number("2"), .number("3"), .operator("-")],
        [.number("0"), .decimal, .clear, .operator("+")],
        [.equals]
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 8) {
                    ForEach(row, id: \.self) { button in
                        CalculatorButtonView(button: button, viewModel: viewModel)
                    }
                }
            }
        }
        .padding()
    }
}
