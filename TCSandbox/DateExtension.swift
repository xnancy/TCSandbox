// http://stackoverflow.com/questions/27182023/getting-the-difference-between-two-nsdates-in-months-days-hours-minutes-seconds

import UIKit

extension NSDate {
    /// Returns the amount of years from another date
    /// Returns the amount of days from another date
    func years(from date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: date, toDate: self, options: []).year ?? 0
    }
    /// Returns the amount of months from another date
    /// Returns the amount of days from another date
    func months (from date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: date, toDate: self, options: []).month ?? 0
    }
    /// Returns the amount of days from another date
    func weeks(from date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear ?? 0
    }
    
    /// Returns the amount of days from another date
    func days(from date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: date, toDate: self, options: []).day ?? 0
    }
    
    /// Returns the amount of hours from another date
    func hours(from date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: date, toDate: self, options: []).hour ?? 0
    }
    
    /// Returns the amount of days from another date
    func minutes(from date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: date, toDate: self, options: []).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds (from date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: date, toDate: self, options: []).second ?? 0
    }
    
    /// Returns the a custom time interval description from another date
    func offset(from date: NSDate) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}