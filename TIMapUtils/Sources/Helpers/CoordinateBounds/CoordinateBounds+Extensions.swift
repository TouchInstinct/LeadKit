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

public extension CoordinateBounds {
    static func from<C: Collection>(coordinates: C) -> Self? where C.Element == Coordinate {
        guard !coordinates.isEmpty else {
            return nil
        }

        var (northEastLon, northEastLat) = (-CLLocationDegrees.infinity, -CLLocationDegrees.infinity)
        var (southWestLon, southWestLat) = (CLLocationDegrees.infinity, CLLocationDegrees.infinity)

        for coordinate in coordinates {
            southWestLon = min(southWestLon, coordinate.longitude)
            northEastLon = max(northEastLon, coordinate.longitude)
            southWestLat = min(southWestLat, coordinate.latitude)
            northEastLat = max(northEastLat, coordinate.latitude)
        }

        return .of(southWest: Coordinate(latitude: southWestLat, longitude: southWestLon),
                   northEast: Coordinate(latitude: northEastLat, longitude: northEastLon))
    }

    var topLeft: Coordinate {
        Coordinate(latitude: northEast.latitude, longitude: southWest.longitude)
    }

    var bottomRight: Coordinate {
        Coordinate(latitude: southWest.latitude, longitude: northEast.longitude)
    }
}
