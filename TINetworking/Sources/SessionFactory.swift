import Foundation
import Alamofire

open class SessionFactory {

    public var timeoutInterval: TimeInterval
    public var additionalHttpHeaders: HTTPHeaders
    public var serverTrustPolicies: [String: ServerTrustEvaluating]

    public init(timeoutInterval: TimeInterval = 20,
                additionalHttpHeaders: HTTPHeaders = HTTPHeaders(),
                trustPolicies: [String: ServerTrustEvaluating] = [:]) {

        self.timeoutInterval = timeoutInterval
        self.additionalHttpHeaders = additionalHttpHeaders
        self.serverTrustPolicies = Dictionary(uniqueKeysWithValues: trustPolicies.map { ($0.key.urlHost, $0.value) })
    }

    open func createSession() -> Session {
        Session(configuration: createSessionConfiguration(),
                serverTrustManager: ServerTrustManager(allHostsMustBeEvaluated: false,
                                                       evaluators: serverTrustPolicies))
    }

    open func createSessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = timeoutInterval
        sessionConfiguration.httpAdditionalHeaders = additionalHttpHeaders.dictionary

        return sessionConfiguration
    }
}
