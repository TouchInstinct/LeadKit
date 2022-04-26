//
//  Copyright (c) 2022 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import CoreLocation

public struct CoordinateBounds {
    public let southWest: CLLocationCoordinate2D
    public let northEast: CLLocationCoordinate2D

    public init(southWest: CLLocationCoordinate2D, northEast: CLLocationCoordinate2D) {
        self.southWest = southWest
        self.northEast = northEast
    }
}

public extension CoordinateBounds {
    static func from<C: Collection>(coordinates: C) -> CoordinateBounds where C.Element == CLLocationCoordinate2D {
        guard let first = coordinates.first else {
            return .init(southWest: CLLocationCoordinate2D(),
                         northEast: CLLocationCoordinate2D())
        }

        let initialBox = CoordinateBounds(southWest: first, northEast: first)

        return coordinates.dropFirst().reduce(initialBox) {
            CoordinateBounds(southWest: CLLocationCoordinate2D(latitude: min($0.southWest.latitude, $1.latitude),
                                                               longitude: min($0.southWest.longitude, $1.longitude)),
                             northEast: CLLocationCoordinate2D(latitude: max($0.northEast.latitude, $1.latitude),
                                                               longitude: max($0.northEast.longitude, $1.longitude)))
        }
    }
}
