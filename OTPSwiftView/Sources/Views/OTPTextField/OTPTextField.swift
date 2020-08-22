//
//  Copyright (c) 2020 Touch Instinct
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

/// Base one symbol textfield
open class OTPTextField: UITextField {
    private let maxSymbolsCount = 1
    
    public weak var previousTextField: OTPTextField?
    public weak var nextTextField: OTPTextField?
    
    public var onTextChangedSignal: VoidClosure?
    public var validationClosure: ValidationClosure<String>?
    public var caretHeight: CGFloat?
    
    public var lastNotEmpty: OTPTextField {
        let isLastNotEmpty = !unwrappedText.isEmpty && nextTextField?.unwrappedText.isEmpty ?? true
        return isLastNotEmpty ? self : nextTextField?.lastNotEmpty ?? self
    }
    
    open override var font: UIFont? {
        didSet {
            if caretHeight == nil, let font = font {
                caretHeight = font.pointSize - font.descender
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        delegate = self
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func deleteBackward() {
        guard unwrappedText.isEmpty else {
            return
        }
        
        onTextChangedSignal?()
        previousTextField?.text = ""
        previousTextField?.becomeFirstResponder()
    }

    public func set(inputText: String) {
        text = inputText.prefix(maxSymbolsCount).string
        
        let nextInputText = inputText.count >= maxSymbolsCount
            ? inputText.suffix(inputText.count - maxSymbolsCount).string
            : ""
        
        nextTextField?.set(inputText: nextInputText)
    }
    
    open override func caretRect(for position: UITextPosition) -> CGRect {
        guard let caretHeight = caretHeight else {
            return super.caretRect(for: position)
        }
        
        var superRect = super.caretRect(for: position)
        superRect.size.height = caretHeight

        return superRect
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self && isFirstResponder ? view : nil
    }
}

extension OTPTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else {
            return true
        }
        
        let isInputEmpty = textField.unwrappedText.isEmpty && string.isEmpty
        
        guard isInputEmpty || validationClosure?(string) ?? true else {
            return false
        }
        
        switch range.length {
        case 0:
            textField.set(inputText: string)
            
            let currentTextField = textField.lastNotEmpty.nextTextField ?? textField.lastNotEmpty
            currentTextField.becomeFirstResponder()
            textField.onTextChangedSignal?()
            
            return false
            
        case 1:
            textField.text = ""
            textField.onTextChangedSignal?()
            return false
            
        default:
            return true
        }
    }
}
