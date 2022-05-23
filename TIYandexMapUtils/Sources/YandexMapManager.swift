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
import YandexMapsMobile

open class YandexMapManager<DataModel>: BaseMapManager<YMKMapView,
                                                        YandexPlacemarkManager<DataModel>,
                                                        YandexClusterPlacemarkManager<DataModel>,
                                                        YMKCameraUpdate> {

    public init<IF: MarkerIconFactory, CIF: MarkerIconFactory>(map: YMKMapView,
                                                               positionGetter: @escaping PositionGetter,
                                                               iconFactory: IF,
                                                               clusterIconFactory: CIF?,
                                                               selectPlacemarkHandler: @escaping SelectPlacemarkHandler)
    where IF.Model == DataModel, CIF.Model == [DataModel] {

        let anyMarkerIconFactory = iconFactory.asAnyMarkerIconFactory()

        super.init(map: map,
                   placemarkManagerCreator: {
            guard let position = positionGetter($0) else {
                return nil
            }

            return YandexPlacemarkManager(dataModel: $0,
                                          position: position,
                                          iconFactory: anyMarkerIconFactory,
                                          tapHandler: $1)
        },
                   clusterPlacemarkManagerCreator: {
            YandexClusterPlacemarkManager(placemarkManagers: $0,
                                          iconFactory: clusterIconFactory,
                                          tapHandler: $1)
        },
                   selectPlacemarkHandler: selectPlacemarkHandler)
    }

    public convenience init(map: YMKMapView,
                            positionGetter: @escaping PositionGetter,
                            defaultMarkerIcon: UIImage,
                            selectPlacemarkHandler: @escaping SelectPlacemarkHandler) {

        self.init(map: map,
                  positionGetter: positionGetter,
                  iconFactory: StaticImageIconFactory(image: defaultMarkerIcon),
                  clusterIconFactory: DefaultClusterMarkerIconFactory(),
                  selectPlacemarkHandler: selectPlacemarkHandler)
    }

    public convenience init(map: YMKMapView,
                            defaultMarkerIcon: UIImage,
                            selectPlacemarkHandler: @escaping SelectPlacemarkHandler)
    where DataModel: MapLocatable, DataModel.Position == YMKPoint {

        self.init(map: map,
                  positionGetter: { $0.position },
                  defaultMarkerIcon: defaultMarkerIcon,
                  selectPlacemarkHandler: selectPlacemarkHandler)
    }

    open override func add(items: [DataModel]) {
        super.add(items: items)

        clusterPlacemarkManager?.addMarkers(to: map.mapWindow.map)
    }
}
