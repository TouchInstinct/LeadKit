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

public extension TotalCountCursorListingResult {

    /// Method that creates DefaultTotalCountCursorListingResult
    /// and initialize it with transformed results
    ///
    /// - Parameter transform: closure to transform results
    /// - Returns: new DefaultTotalCountCursorListingResult instance
    func asDefaultListingResult<E>(transform: ((ElementType) -> E)) -> DefaultTotalCountCursorListingResult<E> {
        DefaultTotalCountCursorListingResult(results: results.map(transform),
                                             totalCount: totalCount)
    }

    /// Method that creates DefaultTotalCountCursorListingResult
    /// and initialize it with results and totalCount
    ///
    /// - Returns: new DefaultTotalCountCursorListingResult instance
    func asDefaultListingResult() -> DefaultTotalCountCursorListingResult<ElementType> {
        DefaultTotalCountCursorListingResult(results: results,
                                             totalCount: totalCount)
    }
}
