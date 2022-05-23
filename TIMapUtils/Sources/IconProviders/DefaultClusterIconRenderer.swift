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

open class DefaultClusterIconRenderer {
    public struct TextAttributes {
        public var font: UIFont
        public var color: UIColor

        public init(font: UIFont, color: UIColor) {
            self.font = font
            self.color = color
        }
    }

    public enum Background {
        case color(UIColor)
        case image(UIImage)
    }

    public struct Border {
        public var strokeSize: CGFloat
        public var color: UIColor

        public init(strokeSize: CGFloat, color: UIColor) {
            self.strokeSize = strokeSize
            self.color = color
        }
    }

    public var textAttributes: TextAttributes
    public var marginToText: CGFloat
    public var background: Background
    public var border: Border

    private var borderWidth: CGFloat {
        border.strokeSize
    }

    public init(textAttributes: TextAttributes = .init(font: .systemFont(ofSize: 48),
                                                       color: .black),
                marginToText: CGFloat = 8,
                background: Background = .color(.orange),
                border: Border = .init(strokeSize: 4, color: .white)) {

        self.textAttributes = textAttributes
        self.marginToText = marginToText
        self.background = background
        self.border = border
    }

    open func format(clusterSize: Int) -> String {
        String(clusterSize)
    }

    open func textDrawingOperation(for text: String) -> TextDrawingOperation {
        let ctFont = CTFontCreateWithFontDescriptorAndOptions(textAttributes.font.fontDescriptor,
                                                              textAttributes.font.pointSize,
                                                              nil,
                                                              [])

        return TextDrawingOperation(text: text,
                                    font: ctFont,
                                    textColor: textAttributes.color.cgColor)
    }

    open func backgroundDrawingOperation(iconSize: CGSize,
                                         iconSizeWithBorder: CGSize,
                                         cornerRadius: CGFloat) -> DrawingOperation? {

        switch background {
        case let .color(color):
            let path = CGPath(roundedRect: CGRect(origin: CGPoint(x: borderWidth, y: borderWidth),
                                                  size: iconSize),
                              cornerWidth: cornerRadius,
                              cornerHeight: cornerRadius,
                              transform: nil)

            return SolidFillDrawingOperation(color: color.cgColor,
                                             path: path)
        case let .image(image):
            guard let cgImage = image.cgImage else {
                return nil
            }
            
            return TransformDrawingOperation(image: cgImage,
                                             imageSize: image.size,
                                             maxNewSize: iconSize,
                                             flipHorizontallyDuringDrawing: true)
        }
    }

    open func borderDrawingOperation(iconSize: CGSize,
                                     cornerRadius: CGFloat) -> DrawingOperation {

        BorderDrawingOperation(frameableContentSize: iconSize,
                               border: borderWidth,
                               color: border.color.cgColor,
                               radius: cornerRadius,
                               exteriorBorder: true)
    }

    open func execute(drawingOperations: [DrawingOperation], inContextWithSize size: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false

        let renderer = UIGraphicsImageRenderer(size: size, format: format)

        return renderer.image {
            for operation in drawingOperations {
                operation.apply(in: $0.cgContext)
            }
        }
    }

    open func renderCluster(of size: Int) -> UIImage {
        let text = format(clusterSize: size)

        var textDrawingOperation = textDrawingOperation(for: text)

        let textSize = textDrawingOperation.affectedArea().size
        let textRadius = sqrt(textSize.height * textSize.height + textSize.width * textSize.width) / 2
        let internalRadius = textRadius + marginToText

        let iconSize = CGSize(width: internalRadius * 2, height: internalRadius * 2)
        let iconSizeWithBorder = CGSize(width: iconSize.width + borderWidth * 2,
                                        height: iconSize.height + borderWidth * 2)

        let radius = CGFloat(min(iconSizeWithBorder.width, iconSizeWithBorder.height) / 2)

        textDrawingOperation.desiredOffset = CGPoint(x: (iconSizeWithBorder.width - textSize.width) / 2,
                                              y: (iconSizeWithBorder.height - textSize.height) / 2)

        let backgroundDrawingOperation = backgroundDrawingOperation(iconSize: iconSize,
                                                                    iconSizeWithBorder: iconSizeWithBorder,
                                                                    cornerRadius: radius)

        let borderDrawindOperation = borderDrawingOperation(iconSize: iconSize,
                                                            cornerRadius: radius)

        let operations = [backgroundDrawingOperation,
                          textDrawingOperation,
                          borderDrawindOperation]
            .compactMap { $0 }

        return execute(drawingOperations: operations,
                       inContextWithSize: iconSizeWithBorder)
    }
}
