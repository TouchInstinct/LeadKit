//
//  Copyright (c) 2018 Touch Instinct
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
public typealias Block<Input, Output> = (Input) -> Output

/// Closure with no arguments and custom return value.
public typealias ResultBlock<Output> = Block<Void, Output>

/// Closure that takes custom arguments and returns Void.
public typealias ParameterBlock<Input> = Block<Input, Void>

/// Closure that takes no arguments and returns Void.
public typealias VoidBlock = ResultBlock<Void>

/// Closure with custom arguments and return value, may throw an error.
public typealias ThrowableBlock<Input, Output> = (Input) throws -> Output

/// Closure that takes no arguments, may throw an error and returns Void.
public typealias ThrowableVoidBlock = ThrowableBlock<Void, Void>
