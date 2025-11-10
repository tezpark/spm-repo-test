# TestPackage

iOS용 Swift Package Manager 테스트 레포지토리입니다. 

v1.0.0

## 요구사항

- iOS 13.0+
- macOS 10.15+
- Swift 5.9+
- Xcode 15.0+

## 설치

### Swift Package Manager

`Package.swift` 파일의 dependencies에 추가:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/TestPackage.git", from: "1.0.0")
]
```

Xcode에서:
1. File > Add Packages...
2. 레포지토리 URL 입력
3. 버전 선택 후 Add Package

## 사용법

### 초기화

```swift
import TestPackage
import TestPackageCore

let config = Configuration(
    apiKey: "your-api-key",
    environment: .production
)

TestPackage.shared.initialize(with: config)
```

### User Service 사용

```swift
let userService = UserService()
userService.configure(with: config)

Task {
    do {
        let user = try await userService.fetchUser(userId: "123")
        print("User: \(user.name)")
    } catch {
        print("Error: \(error)")
    }
}
```

## 프로젝트 구조

```
TestPackage/
├── Package.swift
├── Sources/
│   ├── TestPackage/          # 메인 모듈
│   │   ├── TestPackage.swift
│   │   └── Resources/
│   │       └── config.json
│   └── TestPackageCore/      # 코어 모듈
│       └── Core.swift
└── Tests/
    ├── TestPackageTests/
    │   └── TestPackageTests.swift
    └── TestPackageCoreTests/
        └── TestPackageCoreTests.swift
```

## 테스트 실행

```bash
# 모든 테스트 실행
swift test

# 특정 테스트만 실행
swift test --filter TestPackageTests

# verbose 모드
swift test -v
```

## 빌드

```bash
# Debug 빌드
swift build

# Release 빌드
swift build -c release

# 특정 타겟만 빌드
swift build --target TestPackage
```

## 라이선스

MIT License
