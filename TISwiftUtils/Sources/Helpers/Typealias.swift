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

/// Closure with custom arguments and return value.
public typealias Closure<Input, Output> = (Input) -> Output

/// Closure with no arguments and custom return value.
public typealias ResultClosure<Output> = () -> Output

/// Closure that takes custom arguments and returns Void.
public typealias ParameterClosure<Input> = Closure<Input, Void>

// MARK: Throwable versions

/// Closure with custom arguments and return value, may throw an error.
public typealias ThrowableClosure<Input, Output> = (Input) throws -> Output

/// Closure with no arguments and custom return value, may throw an error.
public typealias ThrowableResultClosure<Output> = () throws -> Output

/// Closure that takes custom arguments and returns Void, may throw an error.
public typealias ThrowableParameterClosure<Input> = ThrowableClosure<Input, Void>

// MARK: Concrete closures

/// Closure that takes no arguments and returns Void.
public typealias VoidClosure = ResultClosure<Void>

/// Closure that takes no arguments, may throw an error and returns Void.
public typealias ThrowableVoidClosure = () throws -> Void
