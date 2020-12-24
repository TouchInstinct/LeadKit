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

import CoreGraphics
import CoreText
import Foundation

public enum FontFormat: String {
    case woff2
}

public extension CTFont {
    enum FontRegistrationError: Error {
        case fontsNotFound
        case unableToCreateCGFontFromData
        case unableToRegisterFont(CFError)
        case unknown
    }

    static func registerFont(at url: URL) throws {
        let fontData = try Data(contentsOf: url)

        guard let dataProvider = CGDataProvider(data: fontData as CFData),
              let font = CGFont(dataProvider) else {
            throw FontRegistrationError.unableToCreateCGFontFromData
        }

        var errorRef: Unmanaged<CFError>?
        let registrationWasSuccessful = CTFontManagerRegisterGraphicsFont(font, &errorRef)

        if registrationWasSuccessful {
            return
        } else if let error = errorRef?.takeRetainedValue() {
            if CFErrorGetCode(error) != CTFontManagerError.alreadyRegistered.rawValue {
                throw FontRegistrationError.unableToRegisterFont(error)
            } else {
                return // it's okay, font is already registered
            }
        } else {
            throw FontRegistrationError.unknown
        }
    }

    static func registerAllFonts(in bundle: Bundle,
                                 withFileExtension fileExtension: String = FontFormat.woff2.rawValue) throws {

        guard let fontUrls = bundle.urls(forResourcesWithExtension: fileExtension,
                                         subdirectory: nil),
              !fontUrls.isEmpty else {
            throw FontRegistrationError.fontsNotFound
        }

        try fontUrls.forEach {
            try registerFont(at: $0)
        }
    }
}
