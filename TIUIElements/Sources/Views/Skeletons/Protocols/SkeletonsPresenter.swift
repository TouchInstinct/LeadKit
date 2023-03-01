//
//  Copyright (c) 2023 Touch Instinct
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

public protocol SkeletonsPresenter {
    var baseView: UIView? { get }
    var skeletonsConfiguration: SkeletonsConfiguration { get }
    var isSkeletonsHidden: Bool { get }
    var viewsToSkeletone: [UIView] { get }

    func showSkeletons()
    func hideSkeletons()
    func startAnimation()
    func stopAnimation()
}

// MARK: - SkeletonsPresenter + Default implemetation

extension SkeletonsPresenter {
    public func showSkeletons() {
        guard let baseView = baseView else {
            return
        }

        baseView.isUserInteractionEnabled = false

        viewsToSkeletone
            .flatMap { view in
                view.isHidden = true

                return getSkeletonLayer(forView: view)
            }
            .map { layer in
                layer.startAnimation()

                return layer
            }
            .insert(onto: baseView)
    }

    public func hideSkeletons() {
        guard let baseView = baseView else {
            return
        }

        baseView.isUserInteractionEnabled = true

        baseView.layer.sublayers?.forEach { layer in
            if let layer = layer as? SkeletonLayer {
                layer.remove(from: baseView)
            }
        }

        baseView.skeletonableViews.forEach {
            $0.isHidden = false
        }
    }

    public func startAnimation() {
        baseView?.layer.skeletonLayers.forEach { layer in
            layer.startAnimation()
        }
    }

    public func stopAnimation() {
        baseView?.layer.skeletonLayers.forEach { layer in
            layer.stopAnimation()
        }
    }

    // MARK: - Private methods

    private func getSkeletonLayer(forView view: UIView) -> [SkeletonLayer] {
        let skeletonLayer = skeletonsConfiguration.createSkeletonLayer(for: baseView)
        var subviewSkeletonLayers = [SkeletonLayer]()

        if view.isSkeletonsContainer {
            if skeletonsConfiguration.borderWidth != .zero {
                skeletonLayer.bind(to: .container(view))
            }

            subviewSkeletonLayers = view.skeletonableViews
                .map(getSkeletonLayer(forView:))
                .flatMap { $0 }

        } else {
            skeletonLayer.bind(to: view.viewType)
        }

        return [skeletonLayer] + subviewSkeletonLayers
    }
}

// MARK: - UIView + SkeletonsPresenter

extension SkeletonsPresenter where Self: UIView {
    public var baseView: UIView? {
        self
    }

    public var isSkeletonsHidden: Bool {
        (layer.sublayers ?? []).first { $0 is SkeletonLayer } == nil
    }

    public var viewsToSkeletone: [UIView] {
        skeletonableViews
    }
}

// MARK: - UIViewController + SkeletonsPresenter

extension SkeletonsPresenter where Self: UIViewController {
    public var baseView: UIView? {
        view
    }

    public var isSkeletonsHidden: Bool {
        (view.layer.sublayers ?? []).first { $0 is SkeletonLayer } == nil
    }

    public var viewsToSkeletone: [UIView] {
        baseView?.skeletonableViews ?? view.skeletonableViews
    }
}

// MARK: - Helper extension

extension Array where Element: CALayer {
    public func insert(onto view: UIView, at index: UInt32 = .max) {
        self.forEach { subLayer in
            view.layer.insertSublayer(subLayer, at: index)
        }
    }
}
