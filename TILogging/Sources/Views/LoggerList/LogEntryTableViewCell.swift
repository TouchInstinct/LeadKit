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

import TIUIKitCore
import TIUIElements
import UIKit
import OSLog

@available(iOS 15, *)
open class LogEntryTableViewCell: ContainerTableViewCell<LogEntryCellView>, ConfigurableView {

    // MARK: - ConfigurableView
    
    open func configure(with entry: OSLogEntryLog) {
        wrappedView.timeLabel.text = entry.date.formatted()
        wrappedView.processLabel.text = entry.process
        wrappedView.messageLabel.text = entry.composedMessage

        configureType(withLevel: entry.level)
    }

    // MARK: - Open methods
    
    open func configureType(withLevel level: OSLogEntryLog.Level) {
        switch level {
        case .error:
            wrappedView.levelTypeView.isHidden = false
            wrappedView.levelTypeView.backgroundColor = .yellow

        case .fault:
            wrappedView.levelTypeView.isHidden = false
            wrappedView.levelTypeView.backgroundColor = .red

        default:
            wrappedView.levelTypeView.isHidden = true 
        }
    }
}
