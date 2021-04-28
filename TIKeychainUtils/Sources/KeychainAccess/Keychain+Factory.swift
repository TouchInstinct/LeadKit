import Foundation
import KeychainAccess

extension Bundle {
    var mirBundleId: String {
        Bundle.main.bundleIdentifier ?? .empty
    }
}

extension Keychain {
    static var mirKeychain: Keychain {
        .init(service: Bundle.main.mirBundleId)
    }
}

private extension String {
    static let empty = ""
}
