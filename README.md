
# Log

A Swift package that provides seamless integration between [LogKit](https://github.com/bwdmr/log-kit) and [Vapor](https://github.com/vapor/vapor), enabling structured logging capabilities for your Vapor applications.

## Requirements

- macOS 13.0+ / iOS 15.0+ / tvOS 15.0+ / watchOS 8.0+
- Swift 6.0+
- Vapor 4.106.0+

## Installation

Add the following to your `Package.swift` file:

```swift
.package(url: "https://github.com/YOUR_REPOSITORY_URL/log.git", from: "1.0.0")
```

And then include it as a dependency in your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Log", package: "log")
    ]
)
```

## Usage

### Basic Setup

1. Configure logging in your Vapor application:

```swift
import Log

let app = try Application(.detect())
defer { app.shutdown() }

// Register your logging service
try await app.log.services.register(app, MyCustomLogService())
```

### Logging from Request Context

You can access the logger from any request context:

```swift
app.get("hello") { req in
    // Access logging functionality through the request
    req.log // Your logging implementation here
    return "Hello, world!"
}
```

### Application-wide Logging

For application-wide logging operations:

```swift
// Access logging functionality through the application instance
app.log // Your logging implementation here
```

## Features

- 🔄 Seamless integration with Vapor's request and application contexts
- 🔒 Thread-safe logging service management
- 🎯 Request-scoped logging capabilities
- ⚡️ Support for async/await
- 🛡️ Built-in error handling with Vapor's abort system

## Architecture

The package provides several key components:

- `Application.Log`: Manages application-wide logging services
- `Request.Log`: Provides request-scoped logging capabilities
- `LogService`: Handles registration and management of logging services
- Built-in error handling with `AbortError` conformance

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[Your chosen license]

---

## Support

For questions and support, please open an issue in the repository.
