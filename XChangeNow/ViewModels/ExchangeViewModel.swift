class ExchangeViewModel: ObservableObject {
    @Published var displayAmount: String = "0"
    @Published var selectedCurrencyIndex: Int = 0
    @Published var convertedAmounts: [Double] = Array(repeating: 0, count: 9)
    @Published var isCalculating = false
    
    private var currentCalculation: String = ""
    private var lastNumber: Double = 0
    private var currentOperator: String?
    private let exchangeService: ExchangeRateService  // 添加这个属性
    
    init(exchangeService: ExchangeRateService = ExchangeRateService()) {  // 添加初始化器
        self.exchangeService = exchangeService
        self.convertedAmounts = Array(repeating: 0, count: Currency.common.count)
    }

    // 获取当前选择的货币
    var selectedCurrency: Currency {
        Currency.common[selectedCurrencyIndex]
    }
    
    // 数字键盘输入处理
    func numberPressed(_ number: Int) {
        if displayAmount == "0" {
            displayAmount = String(number)
        } else {
            displayAmount += String(number)
        }
        Task {
            await updateConversions()
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
        case "÷": result = lastNumber / number
        default: break
        }
        
        displayAmount = String(format: "%.2f", result)
        currentOperator = nil
        Task {
            await updateConversions()
        }
    }
    
    // 清除
    func clear() {
        displayAmount = "0"
        currentOperator = nil
        lastNumber = 0
        Task {
            await updateConversions()
        }
    }
    
    // 更新所有货币转换
    @MainActor
    func updateConversions() async {  // 修改为 async 函数
        guard let amount = Double(displayAmount) else { return }
        
        isCalculating = true
        do {
            for (index, currency) in Currency.common.enumerated() {
                if index != selectedCurrencyIndex {
                    let result = try await exchangeService.convert(
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
            print("转换错误: \(error)")
        }
        isCalculating = false
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
        formatter.maximumFractionDigits = 8
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: number)) ?? "0"
    }
} 