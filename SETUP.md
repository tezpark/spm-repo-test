# TestPackage 설정 가이드

## 📦 프로젝트 구조

```
TestPackage/
├── .github/
│   └── workflows/
│       └── ci.yml              # GitHub Actions CI/CD 설정
├── Sources/
│   ├── TestPackage/            # 메인 모듈
│   │   ├── TestPackage.swift   # SDK 메인 클래스, UserService
│   │   └── Resources/
│   │       └── config.json     # 리소스 파일 예제
│   └── TestPackageCore/        # 코어 모듈
│       └── Core.swift          # Configuration, Logger
├── Tests/
│   ├── TestPackageTests/       # 메인 모듈 테스트
│   │   └── TestPackageTests.swift
│   └── TestPackageCoreTests/   # 코어 모듈 테스트
│       └── TestPackageCoreTests.swift
├── Package.swift               # SPM 매니페스트
├── Makefile                    # 빌드 명령어 모음
├── README.md                   # 프로젝트 문서
├── CONTRIBUTING.md             # 기여 가이드
├── CHANGELOG.md                # 변경 이력
├── LICENSE                     # MIT 라이선스
├── .gitignore                  # Git ignore 설정
└── .swiftlint.yml             # SwiftLint 설정
```

## 🚀 빠른 시작

### 1. 프로젝트 빌드

```bash
cd TestPackage

# Debug 빌드
swift build

# Release 빌드
swift build -c release

# 또는 Makefile 사용
make build
make build-release
```

### 2. 테스트 실행

```bash
# 모든 테스트 실행
swift test

# Verbose 모드
swift test -v

# 특정 테스트만 실행
swift test --filter TestPackageTests

# 또는 Makefile 사용
make test
make test-verbose
```

### 3. Xcode에서 열기

```bash
# 방법 1: 직접 열기
open Package.swift

# 방법 2: Makefile 사용
make xcode
```

## 📝 주요 파일 설명

### Package.swift

Swift Package Manager의 매니페스트 파일입니다. 다음을 정의합니다:

- **Products**: 패키지가 제공하는 라이브러리
  - `TestPackage`: 메인 라이브러리
  - `TestPackageCore`: 코어 라이브러리

- **Dependencies**: 외부 의존성 (현재 없음)

- **Targets**: 빌드 대상
  - `TestPackage`: 메인 타겟
  - `TestPackageCore`: 코어 타겟
  - `TestPackageTests`: 메인 테스트
  - `TestPackageCoreTests`: 코어 테스트

### Sources/TestPackageCore/Core.swift

핵심 기능을 제공합니다:

- `Configuration`: SDK 설정 구조체
- `Environment`: 환경 enum (development, staging, production)
- `ServiceProtocol`: 서비스 프로토콜
- `Logger`: 로깅 유틸리티

### Sources/TestPackage/TestPackage.swift

메인 SDK 기능을 제공합니다:

- `TestPackage`: 싱글톤 SDK 클래스
- `UserService`: 사용자 관리 서비스
- `User`: 사용자 모델
- `ServiceError`: 서비스 에러 enum

## 🧪 테스트 구조

### TestPackageCoreTests

코어 모듈의 단위 테스트:
- Configuration 초기화 테스트
- Logger 테스트
- Environment enum 테스트

### TestPackageTests

메인 모듈의 단위 테스트:
- SDK 초기화 테스트
- User 모델 테스트 (Codable, Equatable)
- UserService 테스트 (async/await)
- 에러 처리 테스트
- 성능 테스트

## 🔧 개발 도구

### Makefile 명령어

```bash
make help              # 사용 가능한 명령어 보기
make build             # 빌드
make test              # 테스트 실행
make clean             # 빌드 파일 정리
make lint              # SwiftLint 실행
make coverage          # 코드 커버리지 생성
make xcode             # Xcode에서 열기
```

### SwiftLint

코드 스타일 검사:

```bash
# 검사 실행
swiftlint lint

# 자동 수정
swiftlint --fix

# 또는 Makefile 사용
make lint
make lint-fix
```

## 📦 SPM 통합

### 다른 프로젝트에서 사용

**Package.swift에 추가:**

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/TestPackage.git", from: "1.0.0")
]

targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "TestPackage", package: "TestPackage")
        ]
    )
]
```

**Xcode에서 추가:**

1. File > Add Packages...
2. 레포지토리 URL 입력
3. 버전 선택
4. Add Package

### 사용 예제

```swift
import TestPackage
import TestPackageCore

// 1. SDK 초기화
let config = Configuration(
    apiKey: "your-api-key",
    environment: .production
)
TestPackage.shared.initialize(with: config)

// 2. UserService 사용
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

## 🔄 CI/CD

GitHub Actions를 통한 자동화:

- **빌드**: iOS 및 macOS 플랫폼
- **테스트**: 모든 테스트 자동 실행
- **코드 커버리지**: 자동 생성
- **SwiftLint**: 코드 스타일 검사

워크플로우 파일: `.github/workflows/ci.yml`

## 📋 체크리스트

새로운 기능 추가 시:

- [ ] 코드 작성
- [ ] 단위 테스트 작성
- [ ] 문서 주석 추가
- [ ] SwiftLint 통과
- [ ] 모든 테스트 통과
- [ ] CHANGELOG 업데이트
- [ ] Pull Request 생성

## 🤝 기여하기

자세한 내용은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참고하세요.

## 📄 라이선스

MIT License - [LICENSE](LICENSE) 파일 참고

## 📚 추가 리소스

- [Swift Package Manager 문서](https://swift.org/package-manager/)
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [SwiftLint 규칙](https://github.com/realm/SwiftLint/blob/main/Rules.md)
