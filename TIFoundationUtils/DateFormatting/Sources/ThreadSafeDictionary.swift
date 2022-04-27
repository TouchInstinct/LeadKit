import Dispatch

public final class ThreadSafeDictionary<K: Hashable, V>: Collection, ExpressibleByDictionaryLiteral {
    private var wrappedDict: [K: V]
    private let concurrentQueue = DispatchQueue(label: "TIFoundationUtils.ThreadSafeDictionary.Queue",
                                                attributes: .concurrent)

    // MARK: - Collection

    public var startIndex: Dictionary<K, V>.Index {
        concurrentQueue.sync {
            self.wrappedDict.startIndex
        }
    }

    public var endIndex: Dictionary<K, V>.Index {
        concurrentQueue.sync {
            self.wrappedDict.endIndex
        }
    }

    // MARK: - ExpressibleByDictionaryLiteral

    public init(dictionaryLiteral elements: (K, V)...) {
        self.wrappedDict = Dictionary(uniqueKeysWithValues: elements)
    }

    // MARK: - Collection

    public func index(after i: Dictionary<K, V>.Index) -> Dictionary<K, V>.Index {
        concurrentQueue.sync {
            self.wrappedDict.index(after: i)
        }
    }

    public subscript(index: Dictionary<K, V>.Index) -> Dictionary<K, V>.Element {
        concurrentQueue.sync {
            self.wrappedDict[index]
        }
    }

    public subscript(key: K) -> V? {
        set {
            concurrentQueue.async(flags: .barrier) {
                self.wrappedDict[key] = newValue
            }
        }
        get {
            concurrentQueue.sync {
                self.wrappedDict[key]
            }
        }
    }
}
