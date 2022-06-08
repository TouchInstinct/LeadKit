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

import Foundation

public extension Result {
    var success: Success? {
        if case let .success(wrapped) = self {
            return wrapped
        }

        return nil
    }
}

extension Result: CodeResponse where Success: CodeResponse {
    public var validUntil: Date? {
        success?.validUntil
    }

    public var codeId: String? {
        success?.codeId
    }

    public var refreshableAfter: Date? {
        success?.refreshableAfter
    }

    public var confirmationId: String? {
        success?.confirmationId
    }

    public var remainingAttempts: Int? {
        success?.remainingAttempts
    }
}

extension Result: CodeRefreshResponse where Success: CodeRefreshResponse {
}

extension Result: CodeConfirmResponse where Success: CodeConfirmResponse {
    public var remainingAttempts: Int? {
        success?.remainingAttempts
    }

    public var requiredAdditionalAuth: String? {
        success?.requiredAdditionalAuth
    }
}
