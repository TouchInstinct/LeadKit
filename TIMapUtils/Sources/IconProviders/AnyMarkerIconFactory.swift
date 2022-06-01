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

import UIKit.UIImage

public final class AnyMarkerIconFactory<Model>: MarkerIconFactory {
    public typealias IconProviderClosure = (Model) -> UIImage

    public var iconProviderClosure: IconProviderClosure

    public init<IF: MarkerIconFactory>(iconFactory: IF) where IF.Model == Model {
        self.iconProviderClosure = { iconFactory.markerIcon(for: $0) }
    }

    public init<IF: MarkerIconFactory, T>(iconFactory: IF, transform: @escaping (Model) -> T) where IF.Model == T {
        self.iconProviderClosure = { iconFactory.markerIcon(for: transform($0)) }
    }

    public func markerIcon(for model: Model) -> UIImage {
        iconProviderClosure(model)
    }
}

public extension MarkerIconFactory {
    func asAnyMarkerIconFactory() -> AnyMarkerIconFactory<Model> {
        .init(iconFactory: self)
    }

    func asAnyMarkerIconFactory<T>(transform: @escaping (T) -> Model) -> AnyMarkerIconFactory<T> {
        .init(iconFactory: self, transform: transform)
    }
}
