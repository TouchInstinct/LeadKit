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

import Foundation
import UIKit.UIGeometry

open class BaseMapManager<Map,
                          PM: PlacemarkManager,
                          CPM: PlacemarkManager,
                          CUF: CameraUpdateFactory> where PM.Position: LocationCoordinate,
                                                          PM.Position == CUF.Position,
                                                          CUF.Update.Map == Map,
                                                          CUF.BoundingBox == CPM.Position {

    public typealias PositionGetter = (PM.DataModel) -> PM.Position?

    public typealias SelectPlacemarkHandler = (PM.DataModel) -> Bool

    public typealias PlacemarkManagerCreator = (PM.DataModel, @escaping PM.TapHandlerClosure) -> PM?
    public typealias ClusterPlacemarkManagerCreator = ([PM], @escaping CPM.TapHandlerClosure) -> CPM

    public typealias CameraUpdateOnPointTap = (CUF.Position) -> CUF.Update
    public typealias CameraUpdateOnClusterTap = (CUF.BoundingBox) -> CUF.Update

    private let placemarkManagerCreator: PlacemarkManagerCreator
    private let clusterPlacemarkManagerCreator: ClusterPlacemarkManagerCreator

    public let map: Map

    public var clusterPlacemarkManager: CPM?

    public var selectPlacemarkHandler: SelectPlacemarkHandler

    public var animationDuration: TimeInterval = 0.5
    public var startCenterPoint = PM.Position(latitude: 59.955477, longitude: 30.2927084)

    public var cameraUpdateOnMarkersAdded: CUF.Update?

    public var cameraUpdateOnMarkerTap: CameraUpdateOnPointTap? = {
        CUF.update(for: .focus(target: $0, zoom: CommonZoomLevels.building.floatValue))
    }

    public var cameraUpdateOnClusterTap: CameraUpdateOnClusterTap? = {
        CUF.update(for: .fit(bounds: $0,
                             insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)))
    }

    public init(map: Map,
                placemarkManagerCreator: @escaping PlacemarkManagerCreator,
                clusterPlacemarkManagerCreator: @escaping ClusterPlacemarkManagerCreator,
                selectPlacemarkHandler: @escaping SelectPlacemarkHandler) {

        self.map = map
        self.placemarkManagerCreator = placemarkManagerCreator
        self.clusterPlacemarkManagerCreator = clusterPlacemarkManagerCreator
        self.selectPlacemarkHandler = selectPlacemarkHandler

        self.cameraUpdateOnMarkersAdded = CUF.update(for: .focus(target: startCenterPoint,
                                                                 zoom: CommonZoomLevels.metropolianArea.floatValue))
    }

    open func set(items: [PM.DataModel]) {
        let placemarkTapHandler: PM.TapHandlerClosure = { [map, selectPlacemarkHandler, animationDuration, cameraUpdateOnMarkerTap] model, location in
            cameraUpdateOnMarkerTap?(location).update(map: map, animationDuration: animationDuration)

            return selectPlacemarkHandler(model)
        }

        let placemarkManagers = items.compactMap { placemarkManagerCreator($0, placemarkTapHandler) }

        let clusterTapHandler: CPM.TapHandlerClosure = { [map, animationDuration, cameraUpdateOnClusterTap] managers, boundingBox in
            cameraUpdateOnClusterTap?(boundingBox).update(map: map, animationDuration: animationDuration)

            return true
        }

        if let clusterManager = clusterPlacemarkManager {
            remove(clusterPlacemarkManager: clusterManager)
        }

        self.clusterPlacemarkManager = clusterPlacemarkManagerCreator(placemarkManagers, clusterTapHandler)

        cameraUpdateOnMarkersAdded?.update(map: map, animationDuration: animationDuration)
    }

    open func remove(clusterPlacemarkManager: CPM) {
        // override in subclass
    }
}
