//
//  Copyright (c) 2023 Touch Instinct
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
import TIFoundationUtils

open class TIDeeplinksService<DeeplinkType: Hashable,
                              Mapper: DeeplinkMapper,
                              Handler: DeeplinkHandler> where Mapper.DeeplinkType == Handler.DeeplinkType,
                                                              Mapper.DeeplinkType == DeeplinkType {

    // MARK: - Private properties

    private var operationQueue: OperationQueue

    private var deeplinkQueue: [DeeplinkType] = []
    private var inProcessingSet: Set<DeeplinkType> = []

    // MARK: - Public properties

    public var deeplinkMapper: Mapper?
    public var deeplinkHandler: Handler?

    // MARK: - Init

    public init(mapper: Mapper, handler: Handler, operationQueue: OperationQueue = .main) {
        self.deeplinkMapper = mapper
        self.deeplinkHandler = handler
        self.operationQueue = operationQueue
    }

    // MARK: - Open methods

    /// Mapping the given url to deeplink model and appending it to the queue.
    /// - Parameter url: URL to map into deeplink model
    /// - Returns: true if a mapper mapped url to deeplink model successfully. Also returns false if `deeplinkMapper` is nil
    @discardableResult
    open func deferredHandle(url: URL) -> Bool {
        let deeplink = deeplinkMapper?.map(url: url)

        guard let deeplink = deeplink else {
            return false
        }

        deeplinkQueue.append(deeplink)

        return true
    }

    open func reset() {
        operationQueue.cancelAllOperations()
        deeplinkQueue.removeAll()
        inProcessingSet.removeAll()
    }

    open func handlePendingDeeplinks() {
        guard let deeplink = deeplinkQueue.first,
              let handler = deeplinkHandler else {
            return
        }

        deeplinkQueue.remove(at: .zero)

        guard !inProcessingSet.contains(deeplink),
              let operation = handler.handle(deeplink: deeplink) else {
            return
        }

        inProcessingSet.formUnion([deeplink])

        let competionOperation = BlockOperation { [weak self] in
            self?.inProcessingSet.subtract([deeplink])
        }

        competionOperation.addDependency(operation)

        competionOperation.add(to: operationQueue)
    }
}
