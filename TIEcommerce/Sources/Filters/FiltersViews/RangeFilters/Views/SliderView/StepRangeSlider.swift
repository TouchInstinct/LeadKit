import TIUIKitCore
import UIKit

open class StepRangeSlider: UIControl, InitializableViewProtocol {

    // MARK: - Public properties

    public let leftThumbView = UIView()
    public let rightThumbView = UIView()

    public let activeTrack = UIView()
    public let trackView = UIView()

    // MARK: - Open properties

    open var disregardedWidth: CGFloat {
        thumbSize
    }

    open var trackUsingWidth: CGFloat {
        frame.width - disregardedWidth
    }

    open var thumbs: [UIView] {
        [leftThumbView, rightThumbView]
    }

    open var leftValue: CGFloat = 0 {
        didSet {
            if leftValue < minimumValue || leftValue > rightValue {
                leftValue = oldValue
            }

            setNeedsLayout()
        }
    }

    open var rightValue: CGFloat = 1000 {
        didSet {
            if rightValue < leftValue || rightValue > maximumValue {
                rightValue = oldValue
            }

            setNeedsLayout()
        }
    }

    open var minimumValue: CGFloat = .zero {
        didSet {
            if minimumValue > maximumValue {
                minimumValue = oldValue
            }

            resetCurrentValues()
            setNeedsLayout()
        }
    }

    open var maximumValue: CGFloat = 1000 {
        didSet {
            if minimumValue > maximumValue && maximumValue <= 0 {
                maximumValue = oldValue
            }

            resetCurrentValues()
            setNeedsLayout()
        }
    }

    open var thumbSize: CGFloat = .thumbSize {
        didSet {
            setNeedsLayout()
        }
    }

    open var trackColor: UIColor = .darkGray {
        didSet {
            trackView.backgroundColor = trackColor
        }
    }

    open var activeTrackColor: UIColor = .systemOrange {
        didSet {
            activeTrack.backgroundColor = activeTrackColor
        }
    }

    open var thumbColor: UIColor = .systemOrange {
        didSet {
            thumbs.forEach {
                $0.backgroundColor = thumbColor
            }
        }
    }

    open var linePath: CGPath {
        let linePath = UIBezierPath()

        linePath.move(to: CGPoint(x: .zero, y: bounds.height / 2))
        linePath.addLine(to: CGPoint(x: frame.width, y: bounds.height / 2))

        return linePath.cgPath
    }

    open var leftThumbCenterPositionToValue: CGFloat {
        let unit = CGFloat(maximumValue) / trackUsingWidth
        return leftThumbView.center.y * unit
    }

    open var rightThumbCenterPositionToValue: CGFloat {
        let unit = CGFloat(maximumValue) / trackUsingWidth
        return rightThumbView.center.y * unit
    }

    open override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: thumbSize)
    }

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initializeView()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Life Cycle

    open override func layoutSubviews() {
        updateTrackViewFrame()
        updateThumbsFrame()
        updateActiveTrack()

        super.layoutSubviews()
    }

    open func addViews() {
        addSubviews(trackView, leftThumbView, rightThumbView)
        trackView.addSubviews(activeTrack)
    }

    open func configureLayout() {
        // override
    }

    open func bindViews() {
        thumbs.forEach {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                              action: #selector(draggingThumb(_:)))
            $0.addGestureRecognizer(panGestureRecognizer)
        }
    }

    open func configureAppearance() {
        trackView.backgroundColor = trackColor
        activeTrack.backgroundColor = activeTrackColor

        thumbs.forEach {
            $0.backgroundColor = thumbColor
        }

        trackView.layer.round(corners: .allCorners, radius: 2)
        updateActiveTrack()
    }

    open func localize() {
        // override
    }

    // MARK: - Internal Methods
    
    func getPositionX(from value: CGFloat) -> CGFloat {
        let unit = trackUsingWidth / (maximumValue - minimumValue)
        return (value - minimumValue) * unit
    }

    // MARK: - Private Methods

    @objc private func draggingThumb(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }

        let translation = gesture.translation(in: self)

        switch gesture.state {
        case .began:
            bringSubviewToFront(view)

        case .changed:
            draggingChanged(view: view, translation: translation.x)

        case .ended:
            sendActions(for: .editingDidEnd)
        default:
            break
        }

        gesture.setTranslation(.zero, in: self)
    }

    private func draggingChanged(view: UIView, translation: CGFloat) {
        switch view {
        case leftThumbView:
            handleDragginLeftThumb(translation: translation)

        case rightThumbView:
            handleDraggingRightThumb(translation: translation)

        default:
            break
        }

        sendActions(for: .valueChanged)
    }

    private func handleDragginLeftThumb(translation: CGFloat) {
        let valueTranslation = maximumValue / (trackUsingWidth / translation)
        var newLeftValue = max(minimumValue, leftValue + valueTranslation)
        newLeftValue = min(newLeftValue, maximumValue)
        newLeftValue = min(newLeftValue, rightValue)

        leftValue = newLeftValue
    }

    private func handleDraggingRightThumb(translation: CGFloat) {
        let valueTranslation = maximumValue / (trackUsingWidth / translation)
        var newRightValue = min(maximumValue, rightValue + valueTranslation)
        newRightValue = max(newRightValue, minimumValue)
        newRightValue = max(newRightValue, leftValue)

        rightValue = newRightValue
    }

    private func updateActiveTrack() {
        activeTrack.frame = .init(x: leftThumbView.frame.maxX,
                                  y: .zero,
                                  width: rightThumbView.frame.minX - leftThumbView.frame.maxX,
                                  height: trackView.frame.height)
    }

    private func updateThumbsFrame() {
        thumbs.forEach {
            $0.layer.round(corners: .allCorners, radius: thumbSize / 2)
        }

        leftThumbView.frame = getLeftThumbRect(from: leftValue)
        rightThumbView.frame = getRightThumbRect(from: rightValue)
    }

    private func updateTrackViewFrame() {
        let trackViewHeight: CGFloat = 3

        trackView.frame = .init(x: .zero,
                                y: (thumbSize - trackViewHeight) / 2,
                                width: bounds.width,
                                height: trackViewHeight)
    }

    private func getLeftThumbRect(from value: CGFloat) -> CGRect {
        .init(x: getPositionX(from: value),
              y: .zero,
              width: thumbSize,
              height: thumbSize)
    }

    private func getRightThumbRect(from value: CGFloat) -> CGRect {
        .init(x: getPositionX(from: value),
              y: .zero,
              width: thumbSize,
              height: thumbSize)
    }

    private func resetCurrentValues() {
        leftValue = minimumValue
        rightValue = maximumValue
    }
}

// MARK: - Constant

private extension CGFloat {
    static let thumbSize: CGFloat = 21
}
