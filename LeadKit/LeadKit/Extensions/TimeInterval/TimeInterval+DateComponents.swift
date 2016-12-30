//
//  TimeInterval+DateComponents.swift
//  LeadKit
//
//  Created by Alexey Gerasimov on 30/12/2016.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

extension TimeInterval {

    private static let secondsInMinute = 60
    private static let minutesInHour   = 60
    private static let hoursInDay      = 24
    private static let secondsInHour   = secondsInMinute * minutesInHour
    private static let secondsInDay    = secondsInHour * hoursInDay

    /**
     Deserialize TimeInterval from string
     Works fine for values like 0:0, 0:0:0, 000:00:00, 0.00:00:00

     - parameter timeString: serialized value
     - parameter timeSeparator: separator between hours and minutes and seconds
     - parameter daySeparator: separator between time value and days count value
     */
    public init(timeString: String, timeSeparator: String = ":", daySeparator: String = ".") {
        let timeComponents = timeString.components(separatedBy: daySeparator)
        let fullDays = Double(timeComponents.first ?? "") ?? 0

        let timeValue = (timeComponents.last ?? "")
            .components(separatedBy: timeSeparator)
            .reversed()
            .enumerated()
            .reduce(0) { interval, part in
                interval + (Double(part.element) ?? 0) * pow(Double(TimeInterval.secondsInMinute), Double(part.offset))
        }

        self = (fullDays * Double(TimeInterval.secondsInDay)) + timeValue
    }

    /**
     Returns a tuple with date components, contained in TimeInterval value
     Supported components: days, hours, minutes, seconds
     */
    public var timeComponents: (days: Int, hours: Int, minutes: Int, seconds: Int) {
        var ti = Int(self)
        let days = (ti / TimeInterval.secondsInDay) % TimeInterval.secondsInDay
        ti -= days * TimeInterval.secondsInDay
        return (
            days,
            (ti / TimeInterval.secondsInHour) % TimeInterval.secondsInHour,
            (ti / TimeInterval.secondsInMinute) % TimeInterval.secondsInMinute,
            ti % TimeInterval.secondsInMinute
        )
    }

}
