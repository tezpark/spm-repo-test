.PHONY: help build test clean lint format resolve-dependencies

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build the package
	@echo "Building package..."
	swift build

build-release: ## Build the package in release mode
	@echo "Building package in release mode..."
	swift build -c release

test: ## Run all tests
	@echo "Running tests..."
	swift test

test-verbose: ## Run tests with verbose output
	@echo "Running tests with verbose output..."
	swift test -v

test-parallel: ## Run tests in parallel
	@echo "Running tests in parallel..."
	swift test --parallel

test-filter: ## Run specific test (usage: make test-filter FILTER=TestName)
	@echo "Running filtered tests..."
	swift test --filter $(FILTER)

clean: ## Clean build artifacts
	@echo "Cleaning build artifacts..."
	swift package clean
	rm -rf .build

reset: clean ## Reset package and resolve dependencies
	@echo "Resetting package..."
	swift package reset

resolve-dependencies: ## Resolve package dependencies
	@echo "Resolving dependencies..."
	swift package resolve

update-dependencies: ## Update package dependencies
	@echo "Updating dependencies..."
	swift package update

lint: ## Run SwiftLint
	@echo "Running SwiftLint..."
	swiftlint lint

lint-fix: ## Run SwiftLint and auto-fix issues
	@echo "Running SwiftLint with auto-fix..."
	swiftlint --fix

format: ## Format Swift code
	@echo "Formatting Swift code..."
	swiftformat Sources Tests

generate-xcodeproj: ## Generate Xcode project
	@echo "Generating Xcode project..."
	swift package generate-xcodeproj

show-dependencies: ## Show package dependencies
	@echo "Package dependencies:"
	swift package show-dependencies

describe: ## Show package description
	@echo "Package description:"
	swift package describe

dump-package: ## Dump Package.swift as JSON
	@echo "Dumping Package.swift..."
	swift package dump-package

archive: ## Create archive for distribution
	@echo "Creating archive..."
	swift build -c release
	cd .build/release && tar -czf ../../TestPackage.tar.gz TestPackage

coverage: ## Generate code coverage report
	@echo "Generating coverage report..."
	swift test --enable-code-coverage
	xcrun llvm-cov report \
		.build/debug/TestPackagePackageTests.xctest/Contents/MacOS/TestPackagePackageTests \
		-instr-profile .build/debug/codecov/default.profdata

xcode: ## Open in Xcode
	@echo "Opening in Xcode..."
	open Package.swift
