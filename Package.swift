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
    .library(name: "OTPSwiftView", targets: ["OTPSwiftView"])
  ],
  targets: [
    .target(name: "TITransitions", path: "TITransitions/Sources"),
    .target(name: "TIUIKitCore", path: "TIUIKitCore/Sources"),
    .target(name: "TISwiftUtils", path: "TISwiftUtils/Sources"),
    .target(name: "TIFoundationUtils", dependencies: ["TISwiftUtils"], path: "TIFoundationUtils/Sources"),
    .target(name: "TIUIElements", dependencies: ["TIUIKitCore"], path: "TIUIElements/Sources"),
    .target(name: "OTPSwiftView", dependencies: ["TIUIKitCore", "TISwiftUtils"], path: "OTPSwiftView/Sources")
  ]
)
