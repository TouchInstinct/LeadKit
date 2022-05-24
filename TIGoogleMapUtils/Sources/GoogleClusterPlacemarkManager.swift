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
import GoogleMapsUtils
import GoogleMaps

open class GoogleClusterPlacemarkManager<Model>: BasePlacemarkManager<GMSMarker, [GooglePlacemarkManager<Model>], GMSCoordinateBounds>,
                                                 GMUClusterRendererDelegate,
                                                 GMUClusterManagerDelegate,
                                                 GMUClusterIconGenerator {

    public var mapDelegate: GMSMapViewDelegate? {
        didSet {
            clusterManager?.setMapDelegate(mapDelegate)
        }
    }

    public private(set) var clusterManager: GMUClusterManager?

    public var defaultClusterIconGenerator = GMUDefaultClusterIconGenerator()

    public init<IF: MarkerIconFactory>(placemarkManagers: [GooglePlacemarkManager<Model>],
                                       iconFactory: IF?,
                                       mapDelegate: GMSMapViewDelegate? = nil,
                                       tapHandler: TapHandlerClosure?) where IF.Model == [Model] {

        super.init(dataModel: placemarkManagers,
                   iconFactory: iconFactory?.asAnyMarkerIconFactory { $0.map { $0.dataModel } },
                   tapHandler: tapHandler)

        self.mapDelegate = mapDelegate
    }

    open func clusterAlgorithm() -> GMUClusterAlgorithm {
        GMUNonHierarchicalDistanceBasedAlgorithm()
    }

    open func clusterRenderer(for map: GMSMapView) -> GMUClusterRenderer {
        let renderer = GMUDefaultClusterRenderer(mapView: map,
                                                 clusterIconGenerator: self)

        renderer.delegate = self

        return renderer
    }

    open func addMarkers(to map: GMSMapView) {
        clusterManager = GMUClusterManager(map: map,
                                           algorithm: clusterAlgorithm(),
                                           renderer: clusterRenderer(for: map))

        clusterManager?.setDelegate(self, mapDelegate: mapDelegate)
        clusterManager?.add(dataModel)
        clusterManager?.cluster()
    }

    open func removeMarkers() {
        clusterManager?.clearItems()
    }

    // MARK: - GMUClusterRendererDelegate

    open func renderer(_ renderer: GMUClusterRenderer, markerFor object: Any) -> GMSMarker? {
        nil
    }

    open func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        switch marker.userData {
        case let cluster as GMUCluster:
            guard let placemarkManagers = cluster.items as? [GooglePlacemarkManager<Model>] else {
                return
            }

            marker.icon = iconFactory?.markerIcon(for: placemarkManagers)
                ?? defaultClusterIconGenerator.icon(forSize: UInt(placemarkManagers.count))
        case let clusterItem as GooglePlacemarkManager<Model>:
            clusterItem.configure(placemark: marker)
        default:
            break
        }
    }

    open func renderer(_ renderer: GMUClusterRenderer, didRenderMarker marker: GMSMarker) {
        // nothing
    }

    // MARK: - GMUClusterManagerDelegate

    open func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        guard let placemarkManagers = cluster.items as? [GooglePlacemarkManager<Model>] else {
            return false
        }

        return tapHandler?(placemarkManagers, .from(coordinates: placemarkManagers.map { $0.position }) ?? .init()) ?? false
    }

    open func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
        guard let placemarkManager = clusterItem as? GooglePlacemarkManager<Model> else {
            return false
        }

        return placemarkManager.tapHandler?(placemarkManager.dataModel, clusterItem.position) ?? false
    }

    // MARK: - GMUClusterIconGenerator

    open func icon(forSize size: UInt) -> UIImage? {
        nil // icon generation will be performed in GMUClusterRendererDelegate callback
    }
}

extension GMSCoordinateBounds: CoordinateBounds {
    public static func of(southWest: CLLocationCoordinate2D, northEast: CLLocationCoordinate2D) -> Self {
        .init(coordinate: southWest, coordinate: northEast)
    }
}
