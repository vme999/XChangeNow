import SwiftUI

enum Theme {
    // 颜色
    static let primary = Color(.red)
    static let secondary = Color(.green)
    static let background = Color(.white)
    static let accent = Color(.blue)
    
    // 字体
    enum Typography {
        static let title = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 17, weight: .semibold)
        static let body = Font.system(size: 16)
        static let caption = Font.system(size: 12)
    }
    
    // 布局
    enum Layout {
        static let spacing: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 16
    }
    
    // 动画
    enum Animation {
        static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let quick = SwiftUI.Animation.easeInOut(duration: 0.2)
    }
}
