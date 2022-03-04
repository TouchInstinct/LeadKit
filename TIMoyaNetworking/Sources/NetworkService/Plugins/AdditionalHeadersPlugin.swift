import Moya
import Alamofire
import Foundation

public protocol AdditionalHeadersPlugin: PluginType {
    var additionalHeaders: HTTPHeaders { get }
}

public extension AdditionalHeadersPlugin {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var modifiedRequest = request

        for header in additionalHeaders {
            modifiedRequest.addValue(header.value, forHTTPHeaderField: header.name)
        }

        return modifiedRequest
    }
}
