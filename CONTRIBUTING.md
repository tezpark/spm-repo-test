# Contributing to TestPackage

TestPackage에 기여해 주셔서 감사합니다! 이 문서는 기여 과정을 안내합니다.

## 개발 환경 설정

### 요구사항

- Xcode 15.0 이상
- Swift 5.9 이상
- SwiftLint (선택사항)

### 설치

```bash
git clone https://github.com/yourusername/TestPackage.git
cd TestPackage
make resolve-dependencies
```

## 개발 워크플로우

### 1. 브랜치 생성

```bash
git checkout -b feature/your-feature-name
```

브랜치 명명 규칙:
- `feature/` - 새로운 기능
- `bugfix/` - 버그 수정
- `docs/` - 문서 업데이트
- `refactor/` - 코드 리팩토링

### 2. 코드 작성

코드 작성 시 다음을 준수해주세요:

- Swift API Design Guidelines를 따릅니다
- 모든 public API에 문서 주석을 작성합니다
- 새로운 기능에는 테스트를 작성합니다
- SwiftLint 규칙을 준수합니다

### 3. 테스트

```bash
# 테스트 실행
make test

# 특정 테스트만 실행
make test-filter FILTER=TestName

# 코드 커버리지 확인
make coverage
```

### 4. 코드 스타일

```bash
# SwiftLint 실행
make lint

# 자동 수정
make lint-fix
```

### 5. 커밋

커밋 메시지 규칙:
- `feat:` - 새로운 기능
- `fix:` - 버그 수정
- `docs:` - 문서 업데이트
- `style:` - 코드 포맷팅
- `refactor:` - 코드 리팩토링
- `test:` - 테스트 추가/수정
- `chore:` - 빌드 설정 등

예시:
```
feat: Add user authentication service
fix: Resolve memory leak in UserService
docs: Update API documentation
```

### 6. Pull Request

1. 변경사항을 푸시합니다:
   ```bash
   git push origin feature/your-feature-name
   ```

2. GitHub에서 Pull Request를 생성합니다

3. PR 설명에 다음을 포함합니다:
   - 변경사항 요약
   - 관련 이슈 번호 (있는 경우)
   - 테스트 방법
   - 스크린샷 (UI 변경 시)

## 코딩 가이드라인

### Swift 스타일

```swift
// ✅ Good
public func fetchUser(userId: String) async throws -> User {
    guard !userId.isEmpty else {
        throw ValidationError.emptyUserId
    }
    
    return try await networkService.getUser(id: userId)
}

// ❌ Bad
public func fetchUser(userId:String)->User{
    return networkService.getUser(id:userId)
}
```

### 문서 주석

```swift
/// Fetches user information from the server
///
/// - Parameter userId: The unique identifier of the user
/// - Returns: User object containing user information
/// - Throws: ServiceError if the request fails
public func fetchUser(userId: String) async throws -> User {
    // Implementation
}
```

### 에러 처리

```swift
// ✅ Good - 명확한 에러 타입
enum ServiceError: Error {
    case notConfigured
    case networkError(underlying: Error)
    case invalidResponse
}

// ❌ Bad - 일반적인 에러
throw NSError(domain: "error", code: -1)
```

## 테스트 작성

### Unit Tests

```swift
func testUserServiceFetchUser() async throws {
    // Given
    let service = UserService()
    let config = Configuration(apiKey: "test")
    service.configure(with: config)
    
    // When
    let user = try await service.fetchUser(userId: "123")
    
    // Then
    XCTAssertEqual(user.id, "123")
}
```

### 테스트 커버리지

- 새로운 기능은 최소 80% 이상의 커버리지를 목표로 합니다
- Critical path는 100% 커버리지를 유지합니다

## 이슈 리포팅

버그를 발견하셨나요? GitHub Issues에서 다음 정보와 함께 리포트해주세요:

- 버그 설명
- 재현 방법
- 예상 동작
- 실제 동작
- 환경 정보 (iOS 버전, Xcode 버전 등)
- 관련 코드나 로그

## 질문하기

질문이 있으시면:
- GitHub Discussions 사용
- Issue에 `question` 라벨로 등록

## 행동 강령

- 존중과 포용의 태도를 유지합니다
- 건설적인 피드백을 제공합니다
- 다른 기여자의 의견을 경청합니다

## 라이선스

이 프로젝트에 기여하면 MIT 라이선스 하에 코드가 배포되는 것에 동의하는 것으로 간주됩니다.
