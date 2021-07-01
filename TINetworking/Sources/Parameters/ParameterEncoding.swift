protocol ParameterEncoding {
    associatedtype Location: ParameterLocation
    associatedtype Result

    func encode(parameters: [String: Parameter<Location>]) -> Result
}
