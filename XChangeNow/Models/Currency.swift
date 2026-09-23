struct Currency: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let flag: String  // 添加国旗emoji属性
    
    static let common: [Currency] = [
        Currency(id: "USD", name: "美元", symbol: "$", flag: "🇺🇸"),
        Currency(id: "EUR", name: "欧元", symbol: "€", flag: "🇪🇺"),
        Currency(id: "GBP", name: "英镑", symbol: "£", flag: "🇬🇧"),
        Currency(id: "JPY", name: "日元", symbol: "¥", flag: "🇯🇵"),
        Currency(id: "CNY", name: "人民币", symbol: "¥", flag: "🇨🇳"),
        Currency(id: "AUD", name: "澳元", symbol: "$", flag: "🇦🇺"),
        Currency(id: "CAD", name: "加元", symbol: "$", flag: "🇨🇦"),
        Currency(id: "CHF", name: "瑞士法郎", symbol: "Fr", flag: "🇨🇭"),
        Currency(id: "HKD", name: "港币", symbol: "$", flag: "🇭🇰"),
        Currency(id: "SGD", name: "新加坡元", symbol: "$", flag: "🇸🇬"),
        Currency(id: "NZD", name: "新西兰元", symbol: "$", flag: "🇳🇿"),
        Currency(id: "KRW", name: "韩元", symbol: "₩", flag: "🇰🇷"),
        Currency(id: "INR", name: "印度卢比", symbol: "₹", flag: "🇮🇳"),
        Currency(id: "TWD", name: "新台币", symbol: "NT$", flag: "🇹🇼"),
        Currency(id: "THB", name: "泰铢", symbol: "฿", flag: "🇹🇭"),
        Currency(id: "AED", name: "阿联酋迪拉姆", symbol: "د.إ", flag: "🇦🇪"),
        Currency(id: "MYR", name: "马来西亚林吉特", symbol: "RM", flag: "🇲🇾"),
        Currency(id: "BRL", name: "巴西雷亚尔", symbol: "R$", flag: "🇧🇷"),
        Currency(id: "SEK", name: "瑞典克朗", symbol: "kr", flag: "🇸🇪"),
        Currency(id: "NOK", name: "挪威克朗", symbol: "kr", flag: "🇳🇴"),
        Currency(id: "DKK", name: "丹麦克朗", symbol: "kr", flag: "🇩🇰"),
        Currency(id: "PLN", name: "波兰兹罗提", symbol: "zł", flag: "🇵🇱"),
        Currency(id: "ZAR", name: "南非兰特", symbol: "R", flag: "🇿🇦"),
        Currency(id: "MXN", name: "墨西哥比索", symbol: "$", flag: "🇲🇽"),
        Currency(id: "ILS", name: "以色列新谢克尔", symbol: "₪", flag: "🇮🇱"),
        Currency(id: "SAR", name: "沙特里亚尔", symbol: "﷼", flag: "🇸🇦"),
        Currency(id: "RUB", name: "俄罗斯卢布", symbol: "₽", flag: "🇷🇺"),
        Currency(id: "TRY", name: "土耳其里拉", symbol: "₺", flag: "🇹🇷"),
        Currency(id: "IDR", name: "印尼盾", symbol: "Rp", flag: "🇮🇩"),
        Currency(id: "PHP", name: "菲律宾比索", symbol: "₱", flag: "🇵🇭")
    ]
    
    // 实现Hashable协议
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // 使用id属性生成hash值
    }
    
    // 已经遵守Equatable协议，默认会使用id进行比较
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.id == rhs.id
    }
}
