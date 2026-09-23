import Foundation
import SwiftUI


enum CalculatorButton: Hashable {
    case number(String)
    case decimal
    case `operator`(String)
    case equals
    case clear
    
    var text: String {
        switch self {
        case .number(let value): return value
        case .decimal: return "."
        case .operator(let symbol): return symbol
        case .equals: return "="
        case .clear: return "C"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .number, .decimal:
            return Color(.systemGray6)
        case .operator:
            return .orange
        case .equals:
            return .blue
        case .clear:
            return Color(.systemRed)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .number, .decimal:
            return .primary
        case .operator, .equals, .clear:
            return .white
        }
    }
    
    // 按钮是否应该占用更大空间
    var isWide: Bool {
        switch self {
        case .equals:
            return true
        default:
            return true
        }
    }
}
