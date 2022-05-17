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

import GoogleMapsUtils
import TIMapUtils

extension GMSCameraUpdate: CameraUpdateFactory, CameraUpdate {
    // MARK: - CameraUpdateFactory

    public static func update(for action: CameraUpdateAction<CLLocationCoordinate2D, GMSCoordinateBounds>) -> GMSCameraUpdate {
        switch action {
        case let .focus(target, zoom):
            return .setTarget(target, zoom: zoom)

        case let .fit(bounds, insets):
            return .fit(bounds, with: insets)

        case .zoomIn:
            return .zoomIn()
            
        case .zoomOut:
            return .zoomOut()
        }
    }

    // MARK: - CameraUpdate

    public func update(map: GMSMapView) {
        map.moveCamera(self)
    }

    public func update(map: GMSMapView, animationDuration: TimeInterval) {
        CATransaction.begin()
        CATransaction.setValue(animationDuration, forKey: kCATransactionAnimationDuration)
        map.animate(with: self)
        CATransaction.commit()
    }
}
