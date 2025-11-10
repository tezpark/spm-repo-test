import Foundation

/// Core configuration for the package
public struct Configuration {
    public let apiKey: String
    public let environment: Environment
    
    public enum Environment {
        case development
        case staging
        case production
    }
    
    public init(apiKey: String, environment: Environment = .production) {
        self.apiKey = apiKey
        self.environment = environment
    }
}

/// Base protocol for services
public protocol ServiceProtocol {
    func configure(with configuration: Configuration)
}

/// Logger utility
public class Logger {
    public enum Level {
        case debug
        case info
        case warning
        case error
    }
    
    public static let shared = Logger()
    
    private init() {}
    
    public func log(_ message: String, level: Level = .info) {
        let prefix: String
        switch level {
        case .debug: prefix = "🔍 DEBUG"
        case .info: prefix = "ℹ️ INFO"
        case .warning: prefix = "⚠️ WARNING"
        case .error: prefix = "❌ ERROR"
        }
        print("[\(prefix)] \(message)")
    }
}
