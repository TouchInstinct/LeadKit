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

import UIKit

open class BasePlacemarkManager<Placemark, Model, Position>: NSObject, PlacemarkManager {
    public typealias TapHandlerClosure = (Model, Position) -> Bool
    public typealias IconProviderClosure = (Model) -> UIImage

    public var tapHandler: TapHandlerClosure?
    public var iconProvider: IconProviderClosure

    public let dataModel: Model

    public init(dataModel: Model,
                iconProvider: @escaping IconProviderClosure,
                tapHandler: TapHandlerClosure?) {

        self.dataModel = dataModel
        self.iconProvider = iconProvider
        self.tapHandler = tapHandler
    }

    public convenience init<IF: MarkerIconFactory>(dataModel: Model,
                                                   iconFactory: IF,
                                                   tapHandler: TapHandlerClosure?) where IF.Model == Model {

        self.init(dataModel: dataModel,
                  iconProvider: { iconFactory.markerIcon(for: $0) },
                  tapHandler: tapHandler)
    }

    // MARK: - PlacemarkManager

    open func configure(placemark: Placemark) {
        // override in subclass
    }
}
