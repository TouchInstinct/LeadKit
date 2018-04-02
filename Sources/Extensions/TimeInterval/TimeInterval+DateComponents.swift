//
//  Copyright (c) 2017 Touch Instinct
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

import Foundation

extension TimeInterval {

    private static let secondsInMinute = 60
    private static let minutesInHour   = 60
    private static let hoursInDay      = 24
    private static let secondsInHour   = secondsInMinute * minutesInHour
    private static let secondsInDay    = secondsInHour * hoursInDay

    public typealias TimeComponents = (days: Int, hours: Int, minutes: Int, seconds: Int)

    /**
     Deserialize TimeInterval from string
     Works fine for values like 0:0, 0:0:0, 000:00:00, 0.00:00:00

     - parameter timeString: serialized value
     - parameter timeSeparator: separator between hours and minutes and seconds
     - parameter daySeparator: separator between time value and days count value
     */
    public init(timeString: String, timeSeparator: String = ":", daySeparator: String = ".") {
        let timeComponents = timeString.components(separatedBy: daySeparator)

        let dayComponent = timeComponents.first ?? ""

        let fullDays = Double(dayComponent) ?? 0

        let timeComponent = timeComponents.last ?? ""

        let timeValue = timeComponent
            .components(separatedBy: timeSeparator)
            .reversed()
            .enumerated()
            .reduce(0.0) { interval, part in
                let partElement = Double(part.element) ?? 0

                return interval + partElement * pow(Double(TimeInterval.secondsInMinute), Double(part.offset))
            }

        self = (fullDays * Double(TimeInterval.secondsInDay)) + timeValue
    }

    /**
     Returns a tuple with date components, contained in TimeInterval value
     Supported components: days, hours, minutes, seconds
     */
    public var timeComponents: TimeComponents {
        var timeInterval = Int(self)
        let days = (timeInterval / TimeInterval.secondsInDay) % TimeInterval.secondsInDay
        timeInterval -= days * TimeInterval.secondsInDay
        return (
            days,
            (timeInterval / TimeInterval.secondsInHour) % TimeInterval.secondsInHour,
            (timeInterval / TimeInterval.secondsInMinute) % TimeInterval.secondsInMinute,
            timeInterval % TimeInterval.secondsInMinute
        )
    }

}
