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
    .library(name: "TIUIElements", targets: ["TIUIElements"])
  ],
  targets: [
    .target(name: "TITransitions", path: "TITransitions/Sources"),
    .target(name: "TIUIKitCore", path: "TIUIKitCore/Sources"),
    .target(name: "TIUIElements", dependencies: ["TIUIKitCore"], path: "TIUIElements/Sources")
  ]
)
