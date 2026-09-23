# XChangeNow

XChangeNow is a SwiftUI currency converter for iOS. Choose a base currency, enter an amount with the built-in keypad, and view conversions across a set of commonly used currencies.

## Features

- Exchange-rate conversion powered by ExchangeRate-API
- Support for 30 commonly used currencies
- Currency selection with flag and currency-code labels
- Built-in calculator keypad for entering and calculating amounts
- In-memory exchange-rate cache with a 30-minute lifetime
- Unit and UI test targets

## Requirements

- macOS with Xcode
- iOS 17.2 or later
- Swift 5
- An ExchangeRate-API key

## Getting started

1. Clone the repository.
2. Open `XChangeNow.xcodeproj` in Xcode.
3. Add your ExchangeRate-API key to `XChangeNow/Config/APIConfig.swift` for local development.
4. Select an iOS Simulator or device and run the app.

## API key safety

Use your own API key for local development and keep it out of version control. Before publishing a fork or a change, replace any local key with a placeholder or load it from an untracked local configuration file.

## Tests

Run the test suite in Xcode with `Product` → `Test`, or press `Command-U`.

## Project structure

```text
XChangeNow/
├── Config/       API configuration
├── Models/       Currency and exchange-rate models
├── Services/     Networking and exchange-rate retrieval
├── ViewModels/   Conversion state and business logic
└── Views/        SwiftUI screens and reusable components
```

## License

No license has been specified for this repository.
