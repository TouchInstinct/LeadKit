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
import TISwiftUtils

public protocol StackRoutable: ModalRoutable {

    /// Module marked as "head" in the stack
    var headModule: Presentable? { get set }

    /// Module on the top of the stack
    var topModule: Presentable? { get }

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?,
              animated: Bool,
              configurationClosure: ConfigurationClosure?)
    
    func push(_ module: Presentable?,
              animated: Bool,
              configurationClosure: ConfigurationClosure?,
              completion: VoidClosure?)

    func popModule()
    func popModule(animated: Bool)
    func popModule(animated: Bool, completion: VoidClosure?)

    func popToHead()
    func popToHead(animated: Bool)

    func pop(to module: Presentable?)
    func pop(to module: Presentable?, animated: Bool)
}
