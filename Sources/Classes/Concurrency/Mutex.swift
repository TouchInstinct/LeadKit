//
//  Copyright (c) 2017 Touch Instinct
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

// Source https://github.com/mattgallagher/CwlUtils/blob/master/Sources/CwlUtils/CwlMutex.swift
final class Mutex {

    // Non-recursive "PTHREAD_MUTEX_NORMAL" and recursive "PTHREAD_MUTEX_RECURSIVE" mutex types.
    enum MutexType {
        case normal
        case recursive
    }

    private var mutex = pthread_mutex_t()

    /// Default constructs as ".Normal" or ".Recursive" on request.
    init(type: MutexType = .normal) {
        var attr = pthread_mutexattr_t()

        guard pthread_mutexattr_init(&attr) == 0 else {
            preconditionFailure("Failed to init mutex attributes!")
        }

        switch type {
        case .normal:
            pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL)
        case .recursive:
            pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        }

        guard pthread_mutex_init(&mutex, &attr) == 0 else {
            preconditionFailure("Failed to init mutex!")
        }
    }

    deinit {
        pthread_mutex_destroy(&mutex)
    }

    func sync<R>(execute work: () throws -> R) rethrows -> R {
        unbalancedLock()

        defer {
            unbalancedUnlock()
        }

        return try work()
    }

    func trySync<R>(execute work: () throws -> R) rethrows -> R? {
        guard unbalancedTryLock() else {
            return nil
        }

        defer {
            unbalancedUnlock()
        }

        return try work()
    }

    func unbalancedLock() {
        pthread_mutex_lock(&mutex)
    }

    func unbalancedTryLock() -> Bool {
        return pthread_mutex_trylock(&mutex) == 0
    }

    func unbalancedUnlock() {
        pthread_mutex_unlock(&mutex)
    }

}
