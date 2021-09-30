// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "LeadKit",
  platforms: [
      .iOS(.v11)
  ],
  products: [

    // MARK: - UIKit
    .library(name: "TIUIKitCore", targets: ["TIUIKitCore"]),
    .library(name: "TIUIElements", targets: ["TIUIElements"]),
    
    // MARK: - Utils
    .library(name: "TISwiftUtils", targets: ["TISwiftUtils"]),
    .library(name: "TIFoundationUtils", targets: ["TIFoundationUtils"]),
    .library(name: "TIKeychainUtils", targets: ["TIKeychainUtils"]),
    .library(name: "TITableKitUtils", targets: ["TITableKitUtils"]),
    .library(name: "TINetworking", targets: ["TINetworking"]),
    
    // MARK: - Elements
    .library(name: "OTPSwiftView", targets: ["OTPSwiftView"]),
    .library(name: "TITransitions", targets: ["TITransitions"]),
    .library(name: "TIPagination", targets: ["TIPagination"]),
  ],
  dependencies: [
    .package(url: "https://github.com/maxsokolov/TableKit.git", .upToNextMajor(from: "2.11.0")),
    .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", .upToNextMajor(from: "4.2.2")),
    .package(url: "https://github.com/petropavel13/Cursors", .upToNextMajor(from: "0.5.1")),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0")),
  ],
  targets: [
    
    // MARK: - UIKit
    .target(name: "TIUIKitCore", path: "TIUIKitCore/Sources"),
    .target(name: "TIUIElements", dependencies: ["TIUIKitCore", "TISwiftUtils"], path: "TIUIElements/Sources"),
    
    // MARK: - Utils
    .target(name: "TISwiftUtils", path: "TISwiftUtils/Sources"),
    .target(name: "TIFoundationUtils", dependencies: ["TISwiftUtils"], path: "TIFoundationUtils/Sources"),
    .target(name: "TIKeychainUtils", dependencies: ["TIFoundationUtils", "KeychainAccess"], path: "TIKeychainUtils/Sources"),
    .target(name: "TITableKitUtils", dependencies: ["TIUIElements", "TableKit"], path: "TITableKitUtils/Sources"),
    .target(name: "TINetworking", dependencies: ["TISwiftUtils", "Alamofire"], path: "TINetworking/Sources"),
    
    // MARK: - Elements

    .target(name: "OTPSwiftView", dependencies: ["TIUIElements"], path: "OTPSwiftView/Sources"),
    .target(name: "TITransitions", path: "TITransitions/Sources"),
    .target(name: "TIPagination", dependencies: ["Cursors", "TISwiftUtils"], path: "TIPagination/Sources"),
    
    // MARK: - Tests
    
    .testTarget(
        name: "TITimerTests",
        dependencies: ["TIFoundationUtils"],
        path: "Tests/TITimerTests"),
  ]
)
