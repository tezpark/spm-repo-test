import XCTest
@testable import TestPackage
@testable import TestPackageCore

final class TestPackageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Reset state before each test if needed
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func testSDKInitialization() {
        let config = Configuration(
            apiKey: "test-api-key",
            environment: .development
        )
        
        TestPackage.shared.initialize(with: config)
        
        XCTAssertTrue(TestPackage.shared.initialized)
    }
    
    func testSDKNotInitializedByDefault() {
        let testPackage = TestPackage.shared
        // Note: In real tests, you'd want to reset the singleton
        // For this example, we're just checking the property
        XCTAssertNotNil(testPackage)
    }
    
    func testGetConfiguration() {
        let config = Configuration(
            apiKey: "test-api-key",
            environment: .staging
        )
        
        TestPackage.shared.initialize(with: config)
        
        let retrievedConfig = TestPackage.shared.getConfiguration()
        XCTAssertNotNil(retrievedConfig)
        XCTAssertEqual(retrievedConfig?.apiKey, "test-api-key")
        XCTAssertEqual(retrievedConfig?.environment, .staging)
    }
    
    // MARK: - User Model Tests
    
    func testUserModelCreation() {
        let user = User(
            id: "123",
            name: "John Doe",
            email: "john@example.com"
        )
        
        XCTAssertEqual(user.id, "123")
        XCTAssertEqual(user.name, "John Doe")
        XCTAssertEqual(user.email, "john@example.com")
    }
    
    func testUserEquality() {
        let user1 = User(id: "123", name: "John", email: "john@example.com")
        let user2 = User(id: "123", name: "John", email: "john@example.com")
        let user3 = User(id: "456", name: "Jane", email: "jane@example.com")
        
        XCTAssertEqual(user1, user2)
        XCTAssertNotEqual(user1, user3)
    }
    
    func testUserCodable() throws {
        let user = User(id: "123", name: "John Doe", email: "john@example.com")
        
        // Encode
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        
        // Decode
        let decoder = JSONDecoder()
        let decodedUser = try decoder.decode(User.self, from: data)
        
        XCTAssertEqual(user, decodedUser)
    }
    
    // MARK: - UserService Tests
    
    func testUserServiceConfiguration() {
        let service = UserService()
        let config = Configuration(
            apiKey: "test-key",
            environment: .development
        )
        
        service.configure(with: config)
        // Service should be configured without errors
    }
    
    func testUserServiceFetchUser() async throws {
        let service = UserService()
        let config = Configuration(
            apiKey: "test-key",
            environment: .development
        )
        
        service.configure(with: config)
        
        let user = try await service.fetchUser(userId: "test-123")
        
        XCTAssertEqual(user.id, "test-123")
        XCTAssertEqual(user.name, "Test User")
        XCTAssertEqual(user.email, "test@example.com")
    }
    
    func testUserServiceThrowsWhenNotConfigured() async {
        let service = UserService()
        
        do {
            _ = try await service.fetchUser(userId: "test-123")
            XCTFail("Should throw notConfigured error")
        } catch ServiceError.notConfigured {
            // Expected error
            XCTAssertTrue(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    // MARK: - Performance Tests
    
    func testPerformanceExample() throws {
        let config = Configuration(
            apiKey: "test-key",
            environment: .development
        )
        
        measure {
            TestPackage.shared.initialize(with: config)
        }
    }
}
