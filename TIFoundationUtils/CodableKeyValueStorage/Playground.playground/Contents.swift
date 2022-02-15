import Foundation
import TIFoundationUtils

struct ProfileInfo: Codable {
    let userName: String
}

extension StorageKey {
    static var profileKey: StorageKey<ProfileInfo> {
        .init(rawValue: "profileKey")
    }

    static var onboardingFinishedKey: StorageKey<Bool> {
        .init(rawValue: "onboardingFinishedKey")
    }
}

var defaults = UserDefaults.standard
defaults[.profileKey] = ProfileInfo(userName: "John Appleseed")
//defaults[.profileKey] = "Agent Smith" // this will threat compile error:
// Cannot assign value of type 'String' to subscript of type 'ProfileInfo'

final class ViewModel {
    @UserDefaultsCodableBackingStore(key: .profileKey, codableKeyValueStorage: .standard)
    var profile: ProfileInfo?

    // This will threat compile error:
    // Cannot convert value of type 'BackingStore<UserDefaults, Bool?>' to specified type 'ProfileInfo?'
//    @UserDefaultsCodableBackingStore(key: .onboardingFinishedKey, codableKeyValueStorage: .standard)
//    var wrongKeyProfile: ProfileInfo?

    // For primitive types we can't use default json decoder/encoder
    @UserDefaultsCodableBackingStore(key: .onboardingFinishedKey,
                                     codableKeyValueStorage: .standard,
                                     decoder: UnarchiverKeyValueDecoder(),
                                     encoder: ArchiverKeyValueEncoder())
    var onboardingFinished = false
}
