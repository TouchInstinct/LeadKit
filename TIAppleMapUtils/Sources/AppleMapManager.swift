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

import TIMapUtils
import MapKit

open class AppleMapManager<DataModel>: BaseMapManager<MKMapView,
                                                        ApplePlacemarkManager<DataModel>,
                                                        AppleClusterPlacemarkManager<DataModel>,
                                                        MKCameraUpdate> {

    public typealias ClusteringIdentifier = String

    public init<IF: MarkerIconFactory, CIF: MarkerIconFactory>(map: MKMapView,
                                                               positionGetter: @escaping PositionGetter,
                                                               clusteringIdentifierGetter: @escaping (DataModel) -> ClusteringIdentifier,
                                                               iconFactory: IF?,
                                                               clusterIconFactory: CIF?,
                                                               mapViewDelegate: MKMapViewDelegate? = nil,
                                                               selectPlacemarkHandler: @escaping SelectPlacemarkHandler)
    where IF.Model == DataModel, CIF.Model == [DataModel] {

        let placemarkManagerCreator: PlacemarkManagerCreator = {
            guard let position = positionGetter($0) else {
                return nil
            }

            return ApplePlacemarkManager(dataModel: $0,
                                         position: position,
                                         clusteringIdentifier: clusteringIdentifierGetter($0),
                                         iconFactory: iconFactory?.asAnyMarkerIconFactory(),
                                         tapHandler: $1)
        }

        let clusterPlacemarkManagerCreator: ClusterPlacemarkManagerCreator = {
            AppleClusterPlacemarkManager(placemarkManagers: $0,
                                         mapViewDelegate: mapViewDelegate,
                                         iconFactory: clusterIconFactory,
                                         tapHandler: $1)
        }

        super.init(map: map,
                   placemarkManagerCreator: placemarkManagerCreator,
                   clusterPlacemarkManagerCreator: clusterPlacemarkManagerCreator,
                   selectPlacemarkHandler: selectPlacemarkHandler)
    }

    public convenience init(map: MKMapView,
                            positionGetter: @escaping PositionGetter,
                            clusteringIdentifierGetter: @escaping (DataModel) -> ClusteringIdentifier,
                            mapViewDelegate: MKMapViewDelegate? = nil,
                            selectPlacemarkHandler: @escaping SelectPlacemarkHandler) {

        self.init(map: map,
                  positionGetter: positionGetter,
                  clusteringIdentifierGetter: clusteringIdentifierGetter,
                  iconFactory: nil as DefaultMarkerIconFactory<DataModel>?,
                  clusterIconFactory: nil as DefaultClusterMarkerIconFactory<DataModel>?,
                  mapViewDelegate: mapViewDelegate,
                  selectPlacemarkHandler: selectPlacemarkHandler)
    }

    public convenience init(map: MKMapView,
                            mapViewDelegate: MKMapViewDelegate? = nil,
                            selectPlacemarkHandler: @escaping SelectPlacemarkHandler) where DataModel: MapLocatable & Clusterable, DataModel.ClusterIdentifier == ClusteringIdentifier, DataModel.Position == CLLocationCoordinate2D {

        self.init(map: map,
                  positionGetter: { $0.position },
                  clusteringIdentifierGetter: { $0.clusterIdentifier },
                  mapViewDelegate: mapViewDelegate,
                  selectPlacemarkHandler: selectPlacemarkHandler)
    }

    open override func set(items: [DataModel]) {
        super.set(items: items)

        clusterPlacemarkManager?.addMarkers(to: map)
    }

    open override func remove(clusterPlacemarkManager: AppleClusterPlacemarkManager<DataModel>) {
        super.remove(clusterPlacemarkManager: clusterPlacemarkManager)

        clusterPlacemarkManager.removeMarkers(from: map)
    }
}
