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

import TISwiftUtils
import TIUIKitCore
import SwiftUI

@available(iOS 13, *)
public extension View {

    /// Presents an alert with a description on a context when a given condition is true.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert. When the user presses or taps one of the alert’s actions, the system sets this value to false and dismisses.
    ///   - context: The view that will show the alert
    ///   - alert: Descriptor of the alert.
    func alert(isPresented: Binding<Bool>,
               on context: AlertPresentationContext,
               alert: AlertDescriptor) -> some View {

        if isPresented.wrappedValue {
            alert.present(on: context) {
                isPresented.wrappedValue = false
            }
        }

        return self
    }

    /// Presents an alert with a description on a context with custom configuration of the alert when a given condition is true.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert. When the user presses or taps one of the alert’s actions, the system sets this value to false and dismisses.
    ///   - context: The view that will show the alert
    ///   - descriptor: Descriptor of the alert.
    ///   - alertViewFactory: A closure called to configure custom alert.
    func alert(isPresented: Binding<Bool>,
               on context: AlertPresentationContext,
               alertDescriptor descriptor: AlertDescriptor,
               alertViewFactory: Closure<AlertDescriptor, AlertPresentable>) -> some View {

        if isPresented.wrappedValue {
            alertViewFactory(descriptor).present(on: context) {
                isPresented.wrappedValue = false
            }
        }

        return self
    }
}
