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

import Foundation
import TISwiftUtils

open class BaseCoordinator: Coordinatable {

    public private(set) var childCoordinators: [Coordinatable] = []

    public var onFinish: ParameterClosure<Coordinatable>?

    public init() {}
    
    open func start() {
        assertionFailure("Method start() has not been implemented")
    }

    public func add(child coordinator: Coordinatable) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    public func remove(child coordinator: Coordinatable?) {
        guard !childCoordinators.isEmpty else {
            return
        }
        guard let coordinator = coordinator else {
            return
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            return
        }
    }

    open func finishFlow() {
        onFinish?(self)
    }
}

// MARK: - Helper
extension BaseCoordinator {

    /// Target (starting) coordinator will added as CHILD to source (current) coordinator.
    /// When target coordinator will finish flow, source coordinator remove target from child coordinators.
    @discardableResult
    public func bindTo<T>(_ coordinator: T) -> T where T: Coordinatable {
        coordinator.onFinish = { [weak self] in
            self?.remove(child: $0)
        }
        add(child: coordinator)

        return coordinator
    }

    /// Life cycle of source (current) coordinator ASSOCIATE to life cycle with target (starting) coordinator.
    /// When target coordinator will finish flow, source coordinator will finish self flow too immediately.
    @discardableResult
    public func dependTo<T>(_ coordinator: T) -> T where T: Coordinatable {
        coordinator.onFinish = { [weak self] in
            self?.remove(child: $0)

            // Associate coordinators life cycles
            if let self = self {
                self.onFinish?(self)
            }
        }
        add(child: coordinator)

        return coordinator
    }
}
