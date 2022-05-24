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

import MapKit
import TIMapUtils

open class MKCameraUpdate: CameraUpdate, CameraUpdateFactory {
    private let action: CameraUpdateAction<CLLocationCoordinate2D, MKMapRect>

    public init(action: CameraUpdateAction<CLLocationCoordinate2D, MKMapRect>) {
        self.action = action
    }

    // MARK: - CameraUpdateFactory

    public static func update(for action: CameraUpdateAction<CLLocationCoordinate2D, MKMapRect>) -> MKCameraUpdate {
        .init(action: action)
    }

    // MARK: - CameraUpdate

    private func update(map: MKMapView, animated: Bool = true) {
        switch action {
        case let .focus(target, zoom):
            map.set(zoomLevel: zoom,
                    at: target,
                    animated: animated)

        case let .fit(bounds, insets):
            map.setVisibleMapRect(bounds,
                                  edgePadding: insets,
                                  animated: animated)

        case .zoomIn:
            map.set(zoomLevel: map.zoomLevel + 1,
                    at: map.centerCoordinate,
                    animated: animated)

        case .zoomOut:
            map.set(zoomLevel: map.zoomLevel - 1,
                    at: map.centerCoordinate,
                    animated: animated)
        }
    }

    public func update(map: MKMapView) {
        update(map: map, animated: false)
    }

    public func update(map: MKMapView, animationDuration: TimeInterval) {
        UIView.animate(withDuration: animationDuration) {
            self.update(map: map, animated: true)
        }
    }
}
