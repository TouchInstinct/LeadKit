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

import Alamofire

/// Enum that represents general api request errors
///
/// - noConnection: No connection to the server (no internet connection, or connection timed out error)
/// - network: Unknown network-related error.
/// - invalidResponse: Invalid server response (response serialization or validation errors).
///   This includes unacceptable status codes (500, etc), json serialization errors, etc.
/// - mapping: Errors that occurs during mapping json into model.
public enum RequestError: Error {

    case noConnection(url: String?)
    case network(error: Error, response: Data?, url: String?)
    case invalidResponse(error: AFError, response: Data?, url: String?)
    case mapping(error: Error, response: Data, url: String?)
}
