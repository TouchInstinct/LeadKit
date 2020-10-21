// swift-tools-version:5.0
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
    .library(name: "TIUIElements", targets: ["TIUIElements"]),
    .library(name: "TITableKitUtils", targets: ["TITableKitUtils"]),
    .library(name: "OTPSwiftView", targets: ["OTPSwiftView"])
  ],
  dependencies: [
    .package(url: "https://github.com/maxsokolov/TableKit.git", from: "2.11.0")
  ],
  targets: [
    .target(name: "TITransitions", path: "TITransitions/Sources"),
    .target(name: "TIUIKitCore", path: "TIUIKitCore/Sources"),
    .target(name: "TISwiftUtils", path: "TISwiftUtils/Sources"),
    .target(name: "TIFoundationUtils", dependencies: ["TISwiftUtils"], path: "TIFoundationUtils/Sources"),
    .target(name: "TIUIElements", dependencies: ["TIUIKitCore"], path: "TIUIElements/Sources"),
    .target(name: "TITableKitUtils", dependencies: ["TIUIElements", "TableKit"], path: "TITableKitUtils/Sources"),
    .target(name: "OTPSwiftView", dependencies: ["TIUIKitCore", "TISwiftUtils"], path: "OTPSwiftView/Sources")
  ]
)
