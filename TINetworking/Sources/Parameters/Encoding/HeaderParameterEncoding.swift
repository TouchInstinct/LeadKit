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

open class HeaderParameterEncoding: ParameterEncoding {
    // MARK: - ParameterEncoding

    open func encode(parameters: [String: Parameter<LocationHeader>]) -> [String: String] {
        parameters.reduce(into: [:]) {
            let key = $1.key
            let nonEmptyValueComponents = pathComponents(fromKey: key, value: $1.value.value)
                .filter { !$0.value.isEmpty || (parameters[key]?.allowEmptyValue ?? true) }
            $0.merge(nonEmptyValueComponents) { _, last in last }
        }
    }

    open func pathComponents(fromKey key: String, value: Any?) -> [String: String] {
        guard let value = value else {
            return [:]
        }

        var components: [String: String] = [:]

        switch value {
        case let dictionary as [String: Any]:
            for (nestedKey, value) in dictionary {
                components.merge(pathComponents(fromKey: nestedKey, value: value)) { _, last in last }
            }
        case let array as [Any]:
            components.updateValue(array.map { "\($0)" }.joined(separator: ","), forKey: key)
        default:
            components.updateValue("\(value)", forKey: key)
        }

        return components
    }
}
