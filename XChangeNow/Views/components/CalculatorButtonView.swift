import SwiftUI

struct CalculatorButtonView: View {
    let button: CalculatorButton
    @ObservedObject var viewModel: ExchangeViewModel
    
    
    var body: some View {
        Button(action: {
            handleTap()
        }) {
            Text(button.text)
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: button.isWide ? .infinity : 80,
                       maxHeight: 50)
                .foregroundColor(button.foregroundColor)
                .background(button.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(maxWidth: button.isWide ? .infinity : 80)
    }
    
    private func handleTap() {
        // 添加触觉反馈
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        switch button {
        case .number(let value):
            if let number = Int(value) {
                viewModel.numberPressed(number)
            }
        case .decimal:
            if !viewModel.displayAmount.contains(".") {
                viewModel.displayAmount += "."
            }
        case .operator(let symbol):
            viewModel.operatorPressed(symbol)
        case .equals:
            viewModel.calculate()
        case .clear:
            viewModel.clear()
        }
    }
}
