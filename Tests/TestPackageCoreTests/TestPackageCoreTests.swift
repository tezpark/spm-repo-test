import XCTest
@testable import TestPackageCore

final class TestPackageCoreTests: XCTestCase {
    
    // MARK: - Configuration Tests
    
    func testConfigurationInitialization() {
        let config = Configuration(
            apiKey: "test-key",
            environment: .development
        )
        
        XCTAssertEqual(config.apiKey, "test-key")
        XCTAssertEqual(config.environment, .development)
    }
    
    func testConfigurationDefaultEnvironment() {
        let config = Configuration(apiKey: "test-key")
        XCTAssertEqual(config.environment, .production)
    }
    
    // MARK: - Logger Tests
    
    func testLoggerSharedInstance() {
        let logger1 = Logger.shared
        let logger2 = Logger.shared
        
        XCTAssertTrue(logger1 === logger2, "Logger should be a singleton")
    }
    
    func testLoggerLogging() {
        // This test just ensures logging doesn't crash
        Logger.shared.log("Test message", level: .debug)
        Logger.shared.log("Test message", level: .info)
        Logger.shared.log("Test message", level: .warning)
        Logger.shared.log("Test message", level: .error)
    }
    
    // MARK: - Environment Tests
    
    func testEnvironmentCases() {
        let environments: [Configuration.Environment] = [
            .development,
            .staging,
            .production
        ]
        
        XCTAssertEqual(environments.count, 3)
    }
}
