//
//  Copyright (c) 2019 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Alamofire
import MobileCoreServices

private enum Constants {

    static let contentTypeKey = "Content-Type"
    static let contentTypeValue = "multipart/form-data; "
    static let boundaryKey = "boundary"
}

enum UploadParametersError: Error {

    case unableGetMimeType
}

/// Struct which keeps base parameters required for upload api request
public struct ApiUploadRequestParameters {

    let formData: MultipartFormData
    let url: URLConvertible
    let headers: HTTPHeaders

    /// ApiUploadRequestParameters initializator (You can get mime type from data using "Swime" pod)
    ///
    /// - Parameters:
    ///   - data: data to upload
    ///   - url: request url
    ///   - additionalHeaders: request additional headers exсept Content-Type
    ///   - fileName: file name with extension
    ///   - name: file name
    ///   - mimeType: file MIME-type
    /// - Throws: UploadParametersError
    public init(data: Data,
                url: URLConvertible,
                additionalHeaders: HTTPHeaders?,
                fileName: String,
                name: String? = nil,
                mimeType: String? = nil) throws {

        let formData = MultipartFormData()

        self.url = url
        self.headers = ApiUploadRequestParameters.configureHTTPHeaders(with: additionalHeaders ?? HTTPHeaders(),
                                                                       formData: formData)

        let name = name ?? (fileName as NSString).deletingPathExtension

        let fileMimeType: String

        if let mimeType = mimeType {
            fileMimeType = mimeType
        } else {
            fileMimeType = try ApiUploadRequestParameters.getFileMimeType(from: fileName)
        }

        formData.append(data, withName: name, fileName: fileName, mimeType: fileMimeType)

        self.formData = formData
    }
}

private extension ApiUploadRequestParameters {

    static func configureHTTPHeaders(with headers: HTTPHeaders,
                                     formData: MultipartFormData) -> HTTPHeaders {

        var requestHeaders = headers

        let boundary = "\(Constants.boundaryKey)=\(formData.boundary)"

        requestHeaders[Constants.contentTypeKey] = Constants.contentTypeValue + boundary

        return requestHeaders
    }

    static func getFileMimeType(from fileName: String) throws -> String {
        let fileExtension = (fileName as NSString).pathExtension

        guard let utiType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                                  fileExtension as CFString,
                                                                  nil)?.takeRetainedValue(),
              let mimeType = UTTypeCopyPreferredTagWithClass(utiType,
                                                             kUTTagClassMIMEType)?.takeRetainedValue() as String? else {

                assertionFailure("Unable to get mime type from file name")
                throw UploadParametersError.unableGetMimeType
        }

        return mimeType
    }
}
