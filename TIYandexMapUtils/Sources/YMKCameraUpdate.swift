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

import YandexMapsMobile
import TIMapUtils

open class YMKCameraUpdate: CameraUpdate, CameraUpdateFactory {
    private let action: CameraUpdateAction<YMKPoint, [YMKPoint]>

    public var animationType = YMKAnimation(type: .smooth, duration: 0.5)

    public init(action: CameraUpdateAction<YMKPoint, [YMKPoint]>) {
        self.action = action
    }

    // MARK: - CameraUpdateFactory

    public static func update(for action: CameraUpdateAction<YMKPoint, [YMKPoint]>) -> YMKCameraUpdate {
        .init(action: action)
    }

    open func cameraPosition(for action: CameraUpdateAction<YMKPoint, [YMKPoint]>,
                             in mapView: YMKMapView) -> YMKCameraPosition {

        let cameraPosition = mapView.mapWindow.map.cameraPosition

        switch action {
        case let .focus(target, zoom):
            return YMKCameraPosition(target: target,
                                     zoom: zoom,
                                     azimuth: 0,
                                     tilt: 0)
            
        case let .fit(bounds, insets):
            return YMKScreenRect.from(coordinates: bounds, in: mapView.mapWindow)?
                .cameraPosition(in: mapView, insets: insets) ?? cameraPosition

        case .zoomIn:
            return YMKCameraPosition(target: cameraPosition.target,
                                     zoom: cameraPosition.zoom + 1,
                                     azimuth: cameraPosition.azimuth,
                                     tilt: cameraPosition.tilt)

        case .zoomOut:
            return YMKCameraPosition(target: cameraPosition.target,
                                     zoom: cameraPosition.zoom - 1,
                                     azimuth: cameraPosition.azimuth,
                                     tilt: cameraPosition.tilt)
        }
    }

    // MARK: - CameraUpdate

    public func update(map: YMKMapView) {
        map.mapWindow.map.move(with: cameraPosition(for: action, in: map))
    }
    
    public func update(map: YMKMapView, animationDuration: TimeInterval) {
        map.mapWindow.map.move(with: cameraPosition(for: action, in: map),
                               animationType: YMKAnimation(type: .smooth, duration: Float(animationDuration)),
                               cameraCallback: nil)
    }
}
