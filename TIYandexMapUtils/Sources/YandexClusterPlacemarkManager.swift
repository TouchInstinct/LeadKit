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
import UIKit
import CoreLocation

open class YandexClusterPlacemarkManager<Model>: BasePlacemarkManager<YMKCluster, [YandexPlacemarkManager<Model>], [YMKPoint]>, YMKClusterListener, YMKClusterTapListener {

    public var placemarksMapping: [CLLocationCoordinate2D: [YandexPlacemarkManager<Model>]]?

    public init(placemarkManagers: [YandexPlacemarkManager<Model>],
                iconProvider: @escaping IconProviderClosure,
                tapHandler: TapHandlerClosure?) {

        super.init(dataModel: placemarkManagers,
                   iconProvider: iconProvider,
                   tapHandler: tapHandler)
    }

    public convenience init<IF: MarkerIconFactory>(placemarkManagers: [YandexPlacemarkManager<Model>],
                                                   iconFactory: IF,
                                                   tapHandler: TapHandlerClosure?) where IF.Model == [Model] {

        self.init(placemarkManagers: placemarkManagers,
                  iconProvider: { iconFactory.markerIcon(for: $0.map { $0.dataModel }) },
                  tapHandler: tapHandler)
    }

    open func addMarkers(to map: YMKMap,
                         clusterRadius: Double = 60,
                         minZoom: UInt = CommonZoomLevels.street.rawValue) {

        let clusterizedPlacemarkCollection = map.mapObjects.addClusterizedPlacemarkCollection(with: self)

        let emptyPlacemarks = clusterizedPlacemarkCollection.addEmptyPlacemarks(with: dataModel.map { $0.position })

        let placemarksZip = zip(emptyPlacemarks, dataModel)

        // [(coordinate, placemarkManager)]
        let mappingSequence = placemarksZip.map { (CLLocationCoordinate2D(ymkPoint: $0.0.geometry), $0.1) }

        // [coordinate: [placemarkManager]]
        self.placemarksMapping = Dictionary(grouping: mappingSequence) { $0.0 }.mapValues { $0.map { $0.1 } }

        placemarksZip.forEach { (placemark, manager) in
            manager.configure(placemark: placemark)
        }

        clusterizedPlacemarkCollection.clusterPlacemarks(withClusterRadius: clusterRadius,
                                                         minZoom: minZoom)
    }

    // MARK: - YMKClusterListener

    open func onClusterAdded(with cluster: YMKCluster) {
        configure(placemark: cluster)
    }

    // MARK: - YMKClusterTapListener

    open func onClusterTap(with cluster: YMKCluster) -> Bool {
        guard let tapHandler = tapHandler else {
            return false
        }

        let managersInCluster = managers(in: cluster)

        return tapHandler(managersInCluster, managersInCluster.map { $0.position })
    }

    open func managers(in cluster: YMKCluster) -> [YandexPlacemarkManager<Model>] {
        cluster.placemarks.flatMap {
            placemarksMapping?[CLLocationCoordinate2D(ymkPoint: $0.geometry)] ?? []
        }
    }

    // MARK: - PlacemarkManager

    open override func configure(placemark: YMKCluster) {
        placemark.addClusterTapListener(with: self)
        placemark.appearance.setIconWith(iconProvider(managers(in: placemark)))
    }
}
