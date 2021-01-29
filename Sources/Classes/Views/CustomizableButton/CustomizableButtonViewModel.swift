//
//  Copyright (c) 2019 Touch Instinct
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

import RxCocoa
import RxSwift

/// viewModel class for CustomizableButtonView configuration
open class CustomizableButtonViewModel {

    public typealias Appearance = CustomizableButtonView.Appearance

    private let stateRelay = BehaviorRelay(value: CustomizableButtonState.enabled)
    private let tapRelay = BehaviorRelay(value: ())
    public let appearance: Appearance
    public let buttonTitle: String

    public init(buttonTitle: String, appearance: Appearance) {
        self.buttonTitle = buttonTitle
        self.appearance = appearance
    }

    open var stateDriver: Driver<CustomizableButtonState> {
        stateRelay.asDriver()
    }

    func bind(tapObservable: Observable<Void>) -> Disposable {
        tapObservable.bind(to: tapRelay)
    }

    public var tapDriver: Driver<Void> {
        tapRelay.asDriver()
    }

    public func updateState(with newState: CustomizableButtonState) {
        stateRelay.accept(newState)
    }
}
