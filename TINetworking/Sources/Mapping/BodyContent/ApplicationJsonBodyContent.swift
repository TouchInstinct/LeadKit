import Foundation

open class ApplicationJsonBodyContent<Body>: BaseContent, BodyContent {
    private let encodingClosure: () throws -> Data

    public init(body: Body, jsonEncoder: JSONEncoder = JSONEncoder()) where Body: Encodable {
        encodingClosure = {
            try jsonEncoder.encode(body)
        }

        super.init(mediaTypeName: CommonMediaTypes.applicationJson.rawValue)
    }

    public init(jsonBody: Body, options: JSONSerialization.WritingOptions = .prettyPrinted) {
        encodingClosure = {
            try JSONSerialization.data(withJSONObject: jsonBody, options: options)
        }

        super.init(mediaTypeName: CommonMediaTypes.applicationJson.rawValue)
    }

    public func encodeBody() throws -> Data {
        try encodingClosure()
    }
}
