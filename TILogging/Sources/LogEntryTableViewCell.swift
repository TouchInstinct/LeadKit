import TIUIKitCore
import TIUIElements
import OSLog

@available(iOS 15, *)
open class LogEntryTableViewCell: BaseInitializableCell, ConfigurableView {
    open func configure(with entry: OSLogEntryLog) {
        textLabel?.text = entry.composedMessage
    }
}
