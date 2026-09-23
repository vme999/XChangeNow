import XCTest
@testable import XChangeNow

class ExchangeViewModelTests: XCTestCase {
    var viewModel: ExchangeViewModel!
    var mockExchangeService: MockExchangeService!
    
    override func setUp() {
        super.setUp()
        mockExchangeService = MockExchangeService()
        viewModel = ExchangeViewModel(exchangeService: mockExchangeService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockExchangeService = nil
        super.tearDown()
    }
    
    func testConvertCurrency() async {
        // 设置测试数据
        viewModel.amount = 100
        viewModel.fromCurrency = Currency.common[0]
        viewModel.toCurrency = Currency.common[1]
        
        // 执行转换
        await viewModel.convertCurrency()
        
        // 验证结果
        XCTAssertNotNil(viewModel.result)
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.result?.toAmount, 723.45)
    }
    
    func testInvalidAmount() async {
        viewModel.amount = -100
        await viewModel.convertCurrency()
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.error is ExchangeError)
    }
} 