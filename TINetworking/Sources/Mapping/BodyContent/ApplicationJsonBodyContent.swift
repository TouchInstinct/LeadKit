import Foundation

open class ApplicationJsonBodyContent<Body>: BodyContent {
    public var mediaTypeName: String {
        CommonMediaTypes.applicationJson.rawValue
    }

    private let encodingClosure: () throws -> Data

    public init(body: Body, jsonEncoder: JSONEncoder = JSONEncoder()) where Body: Encodable {
        self.encodingClosure = {
            try jsonEncoder.encode(body)
        }
    }

    public init(jsonBody: Body, options: JSONSerialization.WritingOptions = .prettyPrinted) {
        self.encodingClosure = {
            try JSONSerialization.data(withJSONObject: jsonBody, options: options)
        }
    }

    public func encodeBody() throws -> Data {
        try encodingClosure()
    }
}
