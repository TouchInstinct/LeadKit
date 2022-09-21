import UIKit

public struct DefaultRangeFilterAppearance {

    public var textFieldsHeight: CGFloat
    public var textFieldsWidth: CGFloat
    public var textFieldLabelsSpacing: CGFloat
    public var textFieldContentInsets: UIEdgeInsets
    public var textFieldsBorderColor: UIColor
    public var textFieldsBorderWidth: CGFloat

    public var sliderColor: UIColor
    public var sliderOffColor: UIColor
    public var thumbSize: CGFloat

    public var textFieldsSpacing: CGFloat
    public var spacing: CGFloat
    public var leadingSpacing: CGFloat
    public var trailingSpacing: CGFloat
    public var fontColor: UIColor

    public init(textFieldsHeight: CGFloat = 32,
                textFieldsWidth: CGFloat = 100,
                textFieldLabelsSpacing: CGFloat = 4,
                textFieldContentInsets: UIEdgeInsets = .zero,
                textFieldsBorderColor: UIColor = .black,
                textFieldsBorderWidth: CGFloat = 1,
                sliderColor: UIColor = .cyan,
                sliderOffColor: UIColor = .darkGray,
                thumbSize: CGFloat = 21,
                textFieldsSpacing: CGFloat = 10,
                spacing: CGFloat = 16,
                leadingSpacing: CGFloat = 16,
                trailingSpacing: CGFloat = 16,
                fontColor: UIColor = .black) {

        self.textFieldsHeight = textFieldsHeight
        self.textFieldsWidth = textFieldsWidth
        self.textFieldLabelsSpacing = textFieldLabelsSpacing
        self.textFieldContentInsets = textFieldContentInsets
        self.textFieldsBorderColor = textFieldsBorderColor
        self.textFieldsBorderWidth = textFieldsBorderWidth
        self.sliderColor = sliderColor
        self.sliderOffColor = sliderOffColor
        self.thumbSize = thumbSize
        self.textFieldsSpacing = textFieldsSpacing
        self.spacing = spacing
        self.leadingSpacing = leadingSpacing
        self.trailingSpacing = trailingSpacing
        self.fontColor = fontColor
    }

    
}

// MARK: - Default appearance

public extension DefaultRangeFilterAppearance {
    static var defaultAppearance: DefaultRangeFilterAppearance {
        .init(textFieldContentInsets: .init(top: 4, left: 8, bottom: 4, right: 8))
    }
}
