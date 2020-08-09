// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "LeadKit",
  platforms: [
      .iOS(.v12)
  ],
  products: [
    .library(name: "TITransitions", targets: ["TITransitions"]),
    .library(name: "TIUIKitCore", targets: ["TIUIKitCore"])
  ],
  targets: [
    .target(name: "TITransitions", path: "TITransitions/Sources"),
    .target(name: "TIUIKitCore", path: "TIUIKitCore/Sources"),
  ]
)
