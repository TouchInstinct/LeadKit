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

private extension Substring.SubSequence {
    func recursivePairCheck(requiredMatches: UInt,
                            sequenceRequiredMatches: UInt,
                            checkClosure: (Character, Character) -> Bool) -> Bool {

        guard sequenceRequiredMatches > 0 else {
            return true
        }

        guard !isEmpty else {
            return false
        }

        let tail = dropFirst()

        guard let current = first, let next = tail.first else {
            return false
        }

        let matched = checkClosure(current, next)

        let reducedMatches = sequenceRequiredMatches - (matched ? 1 : 0)

        let currentSequenceMatch = matched
            && tail.recursivePairCheck(requiredMatches: requiredMatches,
                                       sequenceRequiredMatches: reducedMatches,
                                       checkClosure: checkClosure)

        return currentSequenceMatch || tail.recursivePairCheck(requiredMatches: requiredMatches,
                                                               sequenceRequiredMatches: requiredMatches,
                                                               checkClosure: checkClosure)
    }

    func recursivePairCheck(requiredMatches: UInt, checkClosure: (Character, Character) -> Bool) -> Bool {
        recursivePairCheck(requiredMatches: requiredMatches,
                           sequenceRequiredMatches: requiredMatches,
                           checkClosure: checkClosure)
    }

    func containsOrderedSequence(minLength: UInt, orderingClosure: ((Int, Int) -> Bool)) -> Bool {
        recursivePairCheck(requiredMatches: minLength - 1) {
            guard let current = $0.intValue, let next = $1.intValue else {
                return false
            }

            return orderingClosure(current, next)
        }
    }
}

private extension Character {
    var intValue: Int? {
        return Int(String(self))
    }
}

extension String {
    func containsSequenceOfEqualCharacters(minEqualCharacters: UInt) -> Bool {
        Substring(self).recursivePairCheck(requiredMatches: minEqualCharacters - 1) { $0 == $1 }
    }

    func containsAscendingSequence(minLength: UInt) -> Bool {
        Substring(self).containsOrderedSequence(minLength: minLength) { $0 + 1 == $1 }
    }

    func containsDescendingSequence(minLength: UInt) -> Bool {
        Substring(self).containsOrderedSequence(minLength: minLength) { $0 - 1 == $1 }
    }
}
