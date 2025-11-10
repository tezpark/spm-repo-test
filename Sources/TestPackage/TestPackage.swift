import Foundation
import TestPackageCore

/// Main SDK class
public class TestPackage {
    
    public static let shared = TestPackage()
    
    private var configuration: Configuration?
    private var isInitialized = false
    
    private init() {}
    
    /// Initialize the SDK
    /// - Parameter configuration: Configuration object
    public func initialize(with configuration: Configuration) {
        self.configuration = configuration
        self.isInitialized = true
        Logger.shared.log("TestPackage initialized with environment: \(configuration.environment)", level: .info)
    }
    
    /// Check if SDK is initialized
    public var initialized: Bool {
        return isInitialized
    }
    
    /// Get current configuration
    public func getConfiguration() -> Configuration? {
        return configuration
    }
}

/// User management service
public class UserService: ServiceProtocol {
    
    private var configuration: Configuration?
    
    public init() {}
    
    public func configure(with configuration: Configuration) {
        self.configuration = configuration
    }
    
    /// Fetch user information
    /// - Parameter userId: User ID
    /// - Returns: User object if found
    public func fetchUser(userId: String) async throws -> User {
        guard configuration != nil else {
            throw ServiceError.notConfigured
        }
        
        Logger.shared.log("Fetching user: \(userId)", level: .debug)
        
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        return User(id: userId, name: "Test User", email: "test@example.com")
    }
}

/// User model
public struct User: Codable, Equatable {
    public let id: String
    public let name: String
    public let email: String
    
    public init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}

/// Service errors
public enum ServiceError: Error {
    case notConfigured
    case networkError
    case invalidResponse
}
