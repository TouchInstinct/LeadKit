public protocol ParameterLocation {}

public struct LocationQuery: ParameterLocation {}
public struct LocationPath: ParameterLocation {}
public struct LocationHeader: ParameterLocation {}
public struct LocationCookie: ParameterLocation {}
