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

    private var placemarkCollection: YMKClusterizedPlacemarkCollection?

    public init<IF: MarkerIconFactory>(placemarkManagers: [YandexPlacemarkManager<Model>],
                                       iconFactory: IF?,
                                       tapHandler: TapHandlerClosure?) where IF.Model == [Model] {

        super.init(dataModel: placemarkManagers,
                   iconFactory: iconFactory?.asAnyMarkerIconFactory { $0.map { $0.dataModel } },
                   tapHandler: tapHandler)
    }

    open func addMarkers(to map: YMKMap,
                         clusterRadius: Double = 60,
                         minZoom: UInt = CommonZoomLevels.street.rawValue) {

        let clusterizedPlacemarkCollection = map.mapObjects.addClusterizedPlacemarkCollection(with: self)

        let emptyPlacemarks = clusterizedPlacemarkCollection.addEmptyPlacemarks(with: dataModel.map { $0.position })

        let placemarksZip = zip(emptyPlacemarks, dataModel)

        for (placemark, manager) in placemarksZip {
            manager.configure(placemark: placemark)
            placemark.userData = manager
        }

        clusterizedPlacemarkCollection.clusterPlacemarks(withClusterRadius: clusterRadius,
                                                         minZoom: minZoom)

        self.placemarkCollection = clusterizedPlacemarkCollection
    }

    open func removeMarkers() {
        placemarkCollection?.clear()
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
        cluster.placemarks.compactMap {
            $0.userData as? YandexPlacemarkManager<Model>
        }
    }

    // MARK: - PlacemarkManager

    open override func configure(placemark: YMKCluster) {
        placemark.addClusterTapListener(with: self)
        
        if let customIcon = iconFactory?.markerIcon(for: managers(in: placemark)) {
            placemark.appearance.setIconWith(customIcon)
        }
    }
}
