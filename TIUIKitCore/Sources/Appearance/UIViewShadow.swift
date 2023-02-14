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

public struct UIViewShadow {
    public var radius: CGFloat
    public var offset: CGSize
    public var color: UIColor
    public var opacity: Float

    public init(radius: CGFloat = .zero,
                offset: CGSize = .zero,
                color: UIColor = .clear,
                opacity: Float = .zero) {

        self.radius = radius
        self.offset = offset
        self.color = color
        self.opacity = opacity
    }

    public init(@UIViewShadowBuilder builder: () -> [ShadowComponent]) {
        let components: [ShadowComponent] = builder()

        var radius: CGFloat = .zero
        var offset: CGSize = .zero
        var color: UIColor = .clear
        var opacity: Float = .zero

        for component in components {
            switch component {
            case let component as Radius:
                radius = component.radius

            case let component as Offset:
                offset = component.offset

            case let component as RGBA:
                color = component.uiColor

            case let component as Color:
                color = component.color

            case let component as Opacity:
                opacity = component.opacity

            default:
                continue
            }
        }

        if opacity == .zero, color != .clear {
            opacity = Float(color.cgColor.alpha)
        }

        self.init(radius: radius, offset: offset, color: color, opacity: opacity)
    }
}

// MARK: - UIViewShadowBuilder

@resultBuilder
public struct UIViewShadowBuilder {
    public static func buildBlock(_ components: ShadowComponent...) -> [ShadowComponent] {
        components
    }
}

// MARK: - ShadowComponents

public protocol ShadowComponent {

}

public struct Radius: ShadowComponent {
    public let radius: CGFloat

    public init(_ radius: CGFloat) {
        self.radius = radius
    }
}

public struct Offset: ShadowComponent {
    public let offset: CGSize

    public init(_ offset: CGSize) {
        self.offset = offset
    }

    public init(_ x: CGFloat, _ y: CGFloat) {
        self.offset = .init(width: x, height: y)
    }
}

public struct Color: ShadowComponent {
    public let color: UIColor

    public init(_ color: UIColor) {
        self.color = color
    }
}

public struct RGBA: ShadowComponent {
    public let uiColor: UIColor

    public init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.uiColor = .init(red: r, green: g, blue: b, alpha: a)
    }
}

public struct Opacity: ShadowComponent {
    public let opacity: Float

    public init(_ opacity: Float) {
        self.opacity = opacity
    }
}
