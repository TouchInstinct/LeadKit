import KeychainAccess
import TIFoundationUtils

typealias KeychainCodableBackingStore<T: Codable> = CodableKeyValueBackingStore<Keychain, T>
