//
//  Date.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

extension Date {
    static func from(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+8:00")
        return dateFormatter.date(from: string)!
    }
}

extension Date {
    
    static var milliseconds: TimeInterval {
        get { return Date().timeIntervalSince1970 * 1000 }
    }
    
    // 比较两个时间相差多少天
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    func week() -> String {
        let myWeekday: Int = (Calendar.current as NSCalendar).components([NSCalendar.Unit.weekday], from: self).weekday!
        switch myWeekday {
        case 1:
            return "周日"
        case 2:
            return "周一"
        case 3:
            return "周二"
        case 4:
            return "周三"
        case 5:
            return "周四"
        case 6:
            return "周五"
        case 7:
            return "周六"
        default:
            break
        }
        return "未取到数据"
    }
    
    static func messageAgoSinceDate(_ date: Date) -> String {
        return self.timeAgoSinceDate(date, numericDates: false)
    }
    
    static func timeAgoSinceDate(_ date: Date, numericDates: Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([
            NSCalendar.Unit.minute,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.day,
            NSCalendar.Unit.weekOfYear,
            NSCalendar.Unit.month,
            NSCalendar.Unit.year,
            NSCalendar.Unit.second
            ], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(components.year!) 年前"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 年前"
            } else {
                return "去年"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) 月前"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 个月前"
            } else {
                return "上个月"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) 周前"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 周前"
            } else {
                return "上一周"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) 天前"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 天前"
            } else {
                return "昨天"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) 小时前"
        } else if (components.hour! >= 1){
            return "1 小时前"
        } else if (components.minute! >= 2) {
            return "\(components.minute!) 分钟前"
        } else if (components.minute! >= 1){
            return "1 分钟前"
        } else if (components.second! >= 3) {
            return "\(components.second!) 秒前"
        } else {
            return "刚刚"
        }
    }
}

extension Date {
    /**
     1、如果是列表的第一项，则显示时间；
     2、如果这一条与前面一条间隔两分钟以上，则显示时间
     3、如果这一条是列表的第一项，但是下拉刷新后与前面一条间隔在两分钟之内，仍显示这一条的时间
     4、时间显示格式：
     a) 如果是今天的聊天，显示具体时间。如：11:05
     b) 如果是昨天，或者前天，显示相对日期和具体时间，如：昨天 19:34，前天 20:22
     c) 如果在七天之内，则显示 星期加时间，如：周二 12:23
     d) 如果在一年之内，则显示月份日期 和时间，如：7月18日 12:34
     e) 一年以上的，显示年月日 加时间，如： 2014年6月29日 8:20
     */
    var chatTimeString: String? {
        get {
            let calendar = Calendar.current
            let now = Date()
            let earliest = (now as NSDate).earlierDate(self)
            let latest = (earliest == now) ? self : now
            let components:DateComponents = (calendar as NSCalendar).components([
                NSCalendar.Unit.minute,
                NSCalendar.Unit.hour,
                NSCalendar.Unit.day,
                NSCalendar.Unit.weekOfYear,
                NSCalendar.Unit.month,
                NSCalendar.Unit.year,
                NSCalendar.Unit.second
                ], from: earliest, to: latest, options: NSCalendar.Options())
            
            let nowComponents:DateComponents = (calendar as NSCalendar).components([
                NSCalendar.Unit.minute,
                NSCalendar.Unit.hour,
                NSCalendar.Unit.day,
                NSCalendar.Unit.month,
                NSCalendar.Unit.year,
                ], from: now)
            
            let selfComponents:DateComponents = (calendar as NSCalendar).components([
                NSCalendar.Unit.minute,
                NSCalendar.Unit.hour,
                NSCalendar.Unit.day,
                NSCalendar.Unit.month,
                NSCalendar.Unit.year,
                ], from: earliest)
            
            if nowComponents.year != selfComponents.year {
                return String(format: "%zd年%zd月%zd日 %zd:%zd", selfComponents.year!, selfComponents.month!, selfComponents.day!, selfComponents.hour!, selfComponents.minute!)
            } else if nowComponents.year == selfComponents.year {
                if (components.month! > 0 || components.day! > 7) {
                    return String(format: "%zd月%zd日 %zd:%zd", selfComponents.month!, selfComponents.day!, selfComponents.hour!, selfComponents.minute!)
                } else if (components.day! > 2) {
                    return String(format: "%@ %zd:%zd",self.week(), selfComponents.hour!, selfComponents.minute!)
                } else if (components.day == 2) {
                    return String(format: "前天 %zd:%zd",selfComponents.hour!, selfComponents.minute!)
                } else if (components.day == 1) {
                    return String(format: "昨天 %zd:%zd",selfComponents.hour!, selfComponents.minute!)
                } else {
                    return String(format: "%zd:%zd",selfComponents.hour!, selfComponents.minute!)
                }
            }
            
            return ""
        }
    }
}

extension Date {
    
    /// 判断当前日期是否为今年
    func isThisYear() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let yearComps = calender.component(.year, from: self)
        // 获取现在的年份
        let nowComps = calender.component(.year, from: Date())
        
        return yearComps == nowComps
    }
    
    /// 是否是昨天
    func isYesterday() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let comps = calender.dateComponents([.year, .month, .day], from: self, to: Date())
        // 根据头条显示时间 ，我觉得可能有问题 如果comps.day == 0 显示相同，如果是 comps.day == 1 显示时间不同
        // 但是 comps.day == 1 才是昨天 comps.day == 2 是前天
        //        return comps.year == 0 && comps.month == 0 && comps.day == 1
        return comps.year == 0 && comps.month == 0 && comps.day == 0
    }
    
    /// 是否是前天
    func isBeforeYesterday() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let comps = calender.dateComponents([.year, .month, .day], from: self, to: Date())
        //
        //        return comps.year == 0 && comps.month == 0 && comps.day == 2
        return comps.year == 0 && comps.month == 0 && comps.day == 1
    }
    
    /// 判断是否是今天
    func isToday() -> Bool {
        // 日期格式化
        let formatter = DateFormatter()
        // 设置日期格式
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateStr = formatter.string(from: self)
        let nowStr = formatter.string(from: Date())
        return dateStr == nowStr
    }
    
    func stringCode() -> String {
        // 日期格式化
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let nowStr = formatter.string(from: Date())
        return nowStr
    }
    
}
