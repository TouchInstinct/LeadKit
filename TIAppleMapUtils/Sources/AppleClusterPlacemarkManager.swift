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
import UIKit

open class AppleClusterPlacemarkManager<Model>: BasePlacemarkManager<MKAnnotationView, [ApplePlacemarkManager<Model>], MKMapRect>, MKMapViewDelegate {
    public weak var mapViewDelegate: MKMapViewDelegate?

    private let mapDelegateSelectors = NSObject.instanceMethodSelectors(of: MKMapViewDelegate.self)

    public init(placemarkManagers: [ApplePlacemarkManager<Model>],
                mapViewDelegate: MKMapViewDelegate? = nil,
                iconProvider: @escaping IconProviderClosure,
                tapHandler: TapHandlerClosure?) {

        self.mapViewDelegate = mapViewDelegate

        super.init(dataModel: placemarkManagers,
                   iconProvider: iconProvider,
                   tapHandler: tapHandler)
    }

    public convenience init<IF: MarkerIconFactory>(placemarkManagers: [ApplePlacemarkManager<Model>],
                                                   mapViewDelegate: MKMapViewDelegate? = nil,
                                                   iconFactory: IF,
                                                   tapHandler: TapHandlerClosure?) where IF.Model == [Model] {

        self.init(placemarkManagers: placemarkManagers,
                  mapViewDelegate: mapViewDelegate,
                  iconProvider: { iconFactory.markerIcon(for: $0.map { $0.dataModel }) },
                  tapHandler: tapHandler)
    }

    open func addMarkers(to map: MKMapView) {
        map.delegate = self
        map.addAnnotations(dataModel)
    }

    // MARK: - PlacemarkManager

    override open func configure(placemark: MKAnnotationView) {
        guard let clusterAnnotation = placemark.annotation as? MKClusterAnnotation,
              let placemarkManagers = clusterAnnotation.memberAnnotations as? [ApplePlacemarkManager<Model>] else {
                  return
              }

        placemark.image = iconProvider(placemarkManagers)
    }

    // MARK: - MKMapViewDelegate

    open func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(mapViewDelegate?.responds(to: #selector(mapView(_:viewFor:))) ?? false) else {
            return mapViewDelegate?.mapView?(mapView, viewFor: annotation)
        }

        switch annotation {
        case is MKClusterAnnotation:
            let clusterAnnotationView = MKAnnotationView(annotation: annotation,
                                                         reuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
            configure(placemark: clusterAnnotationView)

            return clusterAnnotationView
        case let placemarkManager as ApplePlacemarkManager<Model>:
            let defaultAnnotationView = MKAnnotationView(annotation: annotation,
                                                         reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

            placemarkManager.configure(placemark: defaultAnnotationView)

            return defaultAnnotationView
        default:
            return nil
        }
    }

    open func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard !(mapViewDelegate?.responds(to: #selector(mapView(_:didSelect:))) ?? false) else {
            mapViewDelegate?.mapView?(mapView, didSelect: view)
            return
        }

        switch view.annotation {
        case let clusterAnnotation as MKClusterAnnotation:
            guard let placemarkManagers = clusterAnnotation.memberAnnotations as? [ApplePlacemarkManager<Model>] else {
                return
            }

            _ = tapHandler?(placemarkManagers, .from(coordinates: placemarkManagers.map { $0.coordinate }))
        case let placemarkManager as ApplePlacemarkManager<Model>:
            _ = placemarkManager.tapHandler?(placemarkManager.dataModel, placemarkManager.coordinate)
        default:
            return
        }
    }

    // MARK: - MKMapViewDelegate selectors forwarding

    open override func responds(to aSelector: Selector) -> Bool {
        let superResponds = super.responds(to: aSelector)

        guard !superResponds else {
            return superResponds
        }

        guard mapDelegateSelectors.contains(aSelector) else {
            return superResponds
        }

        return mapViewDelegate?.responds(to: aSelector) ?? false
    }

    open override func forwardingTarget(for aSelector: Selector) -> Any? {
        guard mapDelegateSelectors.contains(aSelector) else {
            return nil
        }

        return mapViewDelegate
    }
}
