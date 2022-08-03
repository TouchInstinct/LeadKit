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

import UIKit

public struct DefaultFilterPropertyValue: FilterPropertyValueRepresenter,
                                          Codable,
                                          Identifiable {

    public let id: String
    public let title: String
    public let excludingProperties: [String]?

    public var isSelected: Bool

    public func convertToViewModel() -> FilterCellViewModelRepresentable {
        DefaultFilterCellViewModel(id: id,
                                   title: title,
                                   selectedColor: .green,
                                   selectedBgColor: .white,
                                   deselectedBgColor: .lightGray,
                                   insets: .init(top: 4, left: 8, bottom: 4, right: 8),
                                   isSelected: isSelected)
    }
}

public extension DefaultFilterPropertyValue {
    init(id: String, title: String, excludingProperties: [String]? = nil) {
        self.id = id
        self.title = title
        self.excludingProperties = excludingProperties
        self.isSelected = false
    }
}

extension DefaultFilterPropertyValue: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
