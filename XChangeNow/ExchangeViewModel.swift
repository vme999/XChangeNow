import Foundation
import Combine

class ExchangeViewModel: ObservableObject {
    @Published var displayAmount: String = "0"
    @Published var selectedCurrencyIndex: Int = 0
    @Published var convertedAmounts: [Double] = Array(repeating: 0, count: 5)
    @Published var isCalculating = false
    
    private var currentCalculation: String = ""
    private var lastNumber: Double = 0
    private var currentOperator: String?
    
    // 使用 ExchangeRateService 作为 exchangeService
    private let exchangeService: ExchangeRateService
    
    // 初始化器
    init(exchangeService: ExchangeRateService = ExchangeRateService()) {
            self.exchangeService = exchangeService
            self.convertedAmounts = Array(repeating: 0, count: Currency.common.count)  // Use full count
        }
    
    // 获取当前选择的货币
    var selectedCurrency: Currency {
        Currency.common[selectedCurrencyIndex]
    }
    
    // 数字键盘输入处理
    func numberPressed(_ number: Int) {
        if currentOperator != nil && displayAmount == "0" {
            displayAmount = String(number)
        } else if displayAmount == "0" {
            displayAmount = String(number)
        } else {
            displayAmount += String(number)
        }
        
        // 自动更新转换
        Task { @MainActor in
                updateConversions()
            }
    }
    
    // 运算符处理
    func operatorPressed(_ operation: String) {
        guard let number = Double(displayAmount) else { return }
        
        if currentOperator == nil {
            lastNumber = number
            currentOperator = operation
            displayAmount = "0"
        } else {
            calculate()
            currentOperator = operation
        }
    }
    
    // 计算结果
    func calculate() {
        guard let number = Double(displayAmount),
              let operation = currentOperator else { return }
        
        var result: Double = 0
        switch operation {
        case "+": result = lastNumber + number
        case "-": result = lastNumber - number
        case "x": result = lastNumber * number
        case "÷":
            if number != 0 {
                result = lastNumber / number
            } else {
                displayAmount = "错误"
                currentOperator = nil
                return
            }
        default: break
        }
        
        // 格式化结果，最多显示8位小数
        displayAmount = formatNumber(result)
        currentOperator = nil
        lastNumber = result
        
        // 更新转换
        Task { @MainActor in
                updateConversions()
            }
    }
    
    // 清除
    func clear() {
        displayAmount = "0"
        currentOperator = nil
        lastNumber = 0
        Task { @MainActor in
                updateConversions()
            }
    }
    
    // 更新所有货币转换
    @MainActor
    private func updateConversions() {
        guard let amount = Double(displayAmount) else { return }
        
        Task {
            isCalculating = true
            do {
                for (index, currency) in Currency.common.enumerated() {
                    if index != selectedCurrencyIndex {
                        let result = try await self.exchangeService.convert(
                            amount: amount,
                            from: selectedCurrency,
                            to: currency
                        )
                        convertedAmounts[index] = result.toAmount
                    } else {
                        convertedAmounts[index] = amount
                    }
                }
            } catch {
                Task { @MainActor in
                        updateConversions()
                    }
            }
            isCalculating = false
        }
    }
    
    // 处理小数点输入
    func appendDecimal() {
        if !displayAmount.contains(".") {
            displayAmount += "."
        }
    }
    
    // 格式化数字显示
    private func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: number)) ?? "0"
    }
}
