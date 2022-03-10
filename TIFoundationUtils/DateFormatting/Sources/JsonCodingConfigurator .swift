import Foundation

open class JsonCodingConfigurator {
    public let jsonEncoder: JSONEncoder
    public let jsonDecoder: JSONDecoder

    public init(dateFormattersReusePool: DateFormattersReusePool,
                iso8601DateFormattersReusePool: ISO8601DateFormattersReusePool,
                jsonEncoder: JSONEncoder = .init(),
                jsonDecoder: JSONDecoder = .init()) {

        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder

        jsonEncoder.userInfo[.dateFormattersReusePool] = dateFormattersReusePool
        jsonDecoder.userInfo[.dateFormattersReusePool] = dateFormattersReusePool

        jsonEncoder.userInfo[.iso8601DateFormattersReusePool] = iso8601DateFormattersReusePool
        jsonDecoder.userInfo[.iso8601DateFormattersReusePool] = iso8601DateFormattersReusePool
    }
}
