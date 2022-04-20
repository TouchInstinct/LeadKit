public extension ViewText {
    var attributedString: NSAttributedString? {
        guard let text = text else {
            return nil
        }

        return attributes.attributedString(for: text)
    }
}
