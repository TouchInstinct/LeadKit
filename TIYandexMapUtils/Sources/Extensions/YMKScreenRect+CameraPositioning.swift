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

public extension YMKScreenRect {
    func cameraPosition(in mapView: YMKMapView, insets: UIEdgeInsets) -> YMKCameraPosition? {
        let mapWindow: YMKMapWindow = mapView.mapWindow // mapWindow is IUO

        let center = YMKScreenPoint(x: (topLeft.x + bottomRight.x) / 2,
                                    y: (topLeft.y + bottomRight.y) / 2)

        guard let coordinatePoint = mapWindow.screenToWorld(with: center) else {
            return nil
        }

        let mapInsets: UIEdgeInsets

        if #available(iOS 11.0, *) {
            mapInsets = (insets + mapView.safeAreaInsets) * CGFloat(mapWindow.scaleFactor)
        } else {
            mapInsets = insets * CGFloat(mapWindow.scaleFactor)
        }

        let size = CGSize(width: mapWindow.width(), height: mapWindow.height())

        guard let minScale = minScale(for: size, insets: mapInsets) else {
            return nil
        }

        let map = mapWindow.map

        let newZoom = map.cameraPosition.zoom + log2(minScale)
        let minZoom = map.getMinZoom()
        let maxZoom = map.getMaxZoom()

        return YMKCameraPosition(target: coordinatePoint,
                                 zoom: min(max(newZoom, minZoom), maxZoom),
                                 azimuth: 0,
                                 tilt: 0)
    }

    private func minScale(for mapSize: CGSize, insets: UIEdgeInsets) -> Float? {
        let width = CGFloat(abs(bottomRight.x - topLeft.x))
        let height = CGFloat(abs(topLeft.y - bottomRight.y))

        if width > 0 || height > 0 {
            let scaleX = mapSize.width / width - (insets.left + insets.right) / width
            let scaleY = mapSize.height / height - (insets.top + insets.bottom) / height

            return Float(min(scaleX, scaleY))
        }

        return nil
    }
}
