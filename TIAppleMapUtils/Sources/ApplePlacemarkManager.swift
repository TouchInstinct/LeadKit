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

open class ApplePlacemarkManager<Model>: BasePlacemarkManager<MKAnnotationView, Model, CLLocationCoordinate2D>, MKAnnotation {
    // MARK: - MKAnnotation

    public let coordinate: CLLocationCoordinate2D

    public var clusteringIdentifier: String?

    public init(dataModel: Model,
                coordinate: CLLocationCoordinate2D,
                clusteringIdentifier: String?,
                iconProvider: @escaping IconProviderClosure,
                tapHandler: TapHandlerClosure?) {

        self.coordinate = coordinate
        self.clusteringIdentifier = clusteringIdentifier

        super.init(dataModel: dataModel,
                   iconProvider: iconProvider,
                   tapHandler: tapHandler)
    }

    public convenience init<IF: MarkerIconFactory>(dataModel: Model,
                                                   coordinate: CLLocationCoordinate2D,
                                                   clusteringIdentifier: String?,
                                                   iconFactory: IF,
                                                   tapHandler: TapHandlerClosure?) where IF.Model == Model {

        self.init(dataModel: dataModel,
                  coordinate: coordinate,
                  clusteringIdentifier: clusteringIdentifier,
                  iconProvider: { iconFactory.markerIcon(for: $0) },
                  tapHandler: tapHandler)
    }

    // MARK: - PlacemarkManager

    override open func configure(placemark: MKAnnotationView) {
        placemark.image = iconProvider(dataModel)
        placemark.clusteringIdentifier = clusteringIdentifier
    }
}
