open class PathParameterEncoding: BaseUrlParameterEncoding, ParameterEncoding {
    public let templateUrl: String

    public init(templateUrl: String) {
        self.templateUrl = templateUrl
    }

    open func encode(parameters: [String: Parameter<LocationPath>]) -> String  {
        .render(template: templateUrl, using: encode(parameters: parameters))
    }
}
