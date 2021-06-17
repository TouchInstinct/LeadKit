// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "LeadKit",
  platforms: [
      .iOS(.v11)
  ],
  products: [
    .library(name: "TITransitions", targets: ["TITransitions"]),
    .library(name: "TIUIKitCore", targets: ["TIUIKitCore"]),
    .library(name: "TISwiftUtils", targets: ["TISwiftUtils"]),
    .library(name: "TIFoundationUtils", targets: ["TIFoundationUtils"]),
    .library(name: "TIKeychainUtils", targets: ["TIKeychainUtils"]),
    .library(name: "TIUIElements", targets: ["TIUIElements"]),
    .library(name: "TITableKitUtils", targets: ["TITableKitUtils"]),
    .library(name: "OTPSwiftView", targets: ["OTPSwiftView"]),
    .library(name: "TICoordinatorKit", targets: ["TICoordinatorKit"])
  ],
  dependencies: [
    .package(url: "https://github.com/maxsokolov/TableKit.git", from: "2.11.0"),
    .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2")
  ],
  targets: [
    .target(name: "TITransitions", path: "TITransitions/Sources"),
    .target(name: "TIUIKitCore", path: "TIUIKitCore/Sources"),
    .target(name: "TISwiftUtils", path: "TISwiftUtils/Sources"),
    .target(name: "TIFoundationUtils", dependencies: ["TISwiftUtils"], path: "TIFoundationUtils/Sources"),
    .target(name: "TIKeychainUtils", dependencies: ["TIFoundationUtils", "KeychainAccess"], path: "TIKeychainUtils/Sources"),
    .target(name: "TIUIElements", dependencies: ["TIUIKitCore", "TISwiftUtils"], path: "TIUIElements/Sources"),
    .target(name: "TITableKitUtils", dependencies: ["TIUIElements", "TableKit"], path: "TITableKitUtils/Sources"),
    .target(name: "OTPSwiftView", dependencies: ["TIUIElements"], path: "OTPSwiftView/Sources"),
    .target(name: "TICoordinatorKit", dependencies: ["TISwiftUtils"], path: "TICoordinatorKit/Sources")
  ]
)
