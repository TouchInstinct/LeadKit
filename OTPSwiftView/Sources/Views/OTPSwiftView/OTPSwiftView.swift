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
import TIUIKitCore

/// Base full OTP View for entering the verification code
open class OTPSwiftView<View: OTPView>: BaseInitializableControl {
    private var emptyOTPView: View? {
        textFieldsCollection.first { $0.codeTextField.unwrappedText.isEmpty } ?? textFieldsCollection.last
    }

    public private(set) var codeStackView = UIStackView()
    public private(set) var textFieldsCollection: [View] = []
    
    public var onTextEnter: ((String) -> Void)?
    
    public var code: String {
        get {
            textFieldsCollection.compactMap { $0.codeTextField.text }.joined()
        }
        set {
            textFieldsCollection.first?.codeTextField.set(inputText: newValue)
        }
    }
    
    public override var isFirstResponder: Bool {
        !textFieldsCollection.allSatisfy { !$0.codeTextField.isFirstResponder }
    }
    
    open override func addViews() {
        super.addViews()
        
        addSubview(codeStackView)
    }
    
    open override func configureAppearance() {
        super.configureAppearance()
        
        codeStackView.contentMode = .center
        codeStackView.distribution = .fillEqually
    }

    open func configure(with config: OTPCodeConfig) {
        textFieldsCollection = createTextFields(numberOfFields: config.codeSymbolsCount)
        
        codeStackView.addArrangedSubviews(textFieldsCollection)
        codeStackView.spacing = config.spacing
        
        configure(customSpacing: config.customSpacing, for: codeStackView)
        
        bindTextFields(with: config)
    }
    
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        guard let emptyOTPView = emptyOTPView, !emptyOTPView.isFirstResponder else {
            return false
        }
        
        return emptyOTPView.codeTextField.becomeFirstResponder()
    }
    
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        guard let emptyOTPView = emptyOTPView, emptyOTPView.isFirstResponder else {
            return false
        }
        
        return emptyOTPView.codeTextField.resignFirstResponder()
    }
}

// MARK: - Configure textfields

private extension OTPSwiftView {
    func configure(customSpacing: Spacing?, for stackView: UIStackView) {
        guard let customSpacing = customSpacing else {
            return
        }
        
        customSpacing.forEach { [weak self] viewIndex, spacing in
            guard viewIndex < stackView.arrangedSubviews.count, viewIndex >= 0 else {
                return
            }
            
            self?.set(spacing: spacing,
                      after: stackView.arrangedSubviews[viewIndex],
                      at: viewIndex,
                      for: stackView)
        }
    }
    
    func set(spacing: CGFloat,
             after view: UIView,
             at index: Int,
             for stackView: UIStackView) {
        stackView.setCustomSpacing(spacing, after: view)
    }
    
    func createTextFields(numberOfFields: Int) -> [View] {
        var textFieldsCollection: [View] = []
        
        (0..<numberOfFields).forEach { _ in
            let textField = View()
            textField.codeTextField.previousTextField = textFieldsCollection.last?.codeTextField
            textFieldsCollection.last?.codeTextField.nextTextField = textField.codeTextField
            textFieldsCollection.append(textField)
        }
        
        return textFieldsCollection
    }
    
    func bindTextFields(with config: OTPCodeConfig) {
        let onTextChangedSignal: VoidClosure = { [weak self] in
            guard let code = self?.code else { return }
            
            let correctedCode = code.prefix(config.codeSymbolsCount).string
            self?.onTextEnter?(correctedCode)
        }
        
        let onTap: VoidClosure = { [weak self] in
            self?.becomeFirstResponder()
        }
        
        textFieldsCollection.forEach {
            $0.codeTextField.onTextChangedSignal = onTextChangedSignal
            $0.onTap = onTap
        }
    }
}
