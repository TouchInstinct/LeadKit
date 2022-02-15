import Foundation
import TIFoundationUtils

extension StorageKey {
    static var onboardingFinishedKey: StorageKey<Bool> {
        .init(rawValue: "onboardingFinishedKey")
    }
}

final class ViewModel {
    @UserDefaultsBackingStore(key: .onboardingFinishedKey,
                              userDefaultsStorage: .standard,
                              getClosure: { $0.bool(forKey: $1) },
                              setClosure: { $0.set($1, forKey: $2) })
    var hasFinishedOnboarding = false // default value if nothing was stored in defaults
}
