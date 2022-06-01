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
import GoogleMaps

open class GoogleMapManager<DataModel>: BaseMapManager<GMSMapView,
                                                        GooglePlacemarkManager<DataModel>,
                                                        GoogleClusterPlacemarkManager<DataModel>,
                                                        GMSCameraUpdate> {

    public init<IF: MarkerIconFactory, CIF: MarkerIconFactory>(map: GMSMapView,
                                                               positionGetter: @escaping PositionGetter,
                                                               iconFactory: IF?,
                                                               clusterIconFactory: CIF?,
                                                               mapViewDelegate: GMSMapViewDelegate? = nil,
                                                               selectPlacemarkHandler: @escaping SelectPlacemarkHandler)
    where IF.Model == DataModel, CIF.Model == [DataModel] {

        let placemarkManagerCreator: PlacemarkManagerCreator = {
            guard let position = positionGetter($0) else {
                return nil
            }

            return GooglePlacemarkManager(dataModel: $0,
                                          position: position,
                                          iconFactory: iconFactory?.asAnyMarkerIconFactory(),
                                          tapHandler: $1)
        }

        let clusterPlacemarkManagerCreator: ClusterPlacemarkManagerCreator = {
            GoogleClusterPlacemarkManager(placemarkManagers: $0,
                                          iconFactory: clusterIconFactory,
                                          mapDelegate: mapViewDelegate,
                                          tapHandler: $1)
        }

        super.init(map: map,
                   placemarkManagerCreator: placemarkManagerCreator,
                   clusterPlacemarkManagerCreator: clusterPlacemarkManagerCreator,
                   selectPlacemarkHandler: selectPlacemarkHandler)
    }

    public convenience init(map: GMSMapView,
                            positionGetter: @escaping PositionGetter,
                            mapViewDelegate: GMSMapViewDelegate? = nil,
                            selectPlacemarkHandler: @escaping SelectPlacemarkHandler) {

        self.init(map: map,
                  positionGetter: positionGetter,
                  iconFactory: nil as DefaultMarkerIconFactory<DataModel>?,
                  clusterIconFactory: nil as DefaultClusterMarkerIconFactory<DataModel>?,
                  mapViewDelegate: mapViewDelegate,
                  selectPlacemarkHandler: selectPlacemarkHandler)
    }

    public convenience init(map: GMSMapView,
                            mapViewDelegate: GMSMapViewDelegate? = nil,
                            selectPlacemarkHandler: @escaping SelectPlacemarkHandler) where DataModel: MapLocatable, DataModel.Position == CLLocationCoordinate2D {

        self.init(map: map,
                  positionGetter: { $0.position },
                  mapViewDelegate: mapViewDelegate,
                  selectPlacemarkHandler: selectPlacemarkHandler)
    }

    open override func set(items: [DataModel]) {
        super.set(items: items)

        clusterPlacemarkManager?.addMarkers(to: map)
    }

    open override func remove(clusterPlacemarkManager: GoogleClusterPlacemarkManager<DataModel>) {
        super.remove(clusterPlacemarkManager: clusterPlacemarkManager)

        clusterPlacemarkManager.removeMarkers()
    }
}
