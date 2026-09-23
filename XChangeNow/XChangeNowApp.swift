import SwiftUI

@main
struct XChangeNowApp: App {
    @StateObject private var exchangeViewModel: ExchangeViewModel

    init() {
        let exchangeService = ExchangeRateService()
        _exchangeViewModel = StateObject(wrappedValue: ExchangeViewModel(exchangeService: exchangeService))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(exchangeViewModel)
                .preferredColorScheme(.light)
                .accentColor(Theme.accent)
                .background(Theme.background)
        }
    }
    
    private func setupAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(Theme.background)
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)  // 修正这里的参数名
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        UITextField.appearance().tintColor = UIColor(Theme.accent)
    }
}
