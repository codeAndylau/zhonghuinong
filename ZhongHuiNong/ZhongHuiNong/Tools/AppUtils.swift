//
//  AppUtils.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/30.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

struct AppUtils {
    
    static let shared = AppUtils()
    
   
    /// 割圆角
    ///
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - radius: <#radius description#>
    func clipsViewCorner(_ view: UIView, radius: Int) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    
    /// 获取当前时间
    ///
    /// - Parameter date: <#date description#>
    /// - Returns: <#return value description#>
    func getCurrentDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = date
        return dateFormatter.string(from: Date())
    }
    
    
    /// 获取当前星期
    ///
    /// - Returns: <#return value description#>
    func getCurrentWeek() -> String {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        return (comps.weekday! - 1).description
    }
    
    
    /// 获取时间和星期
    ///
    /// - Parameter date: <#date description#>
    /// - Returns: <#return value description#>
    func getCurrentDayAndTime(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let timeStr = dateFormatter.string(from: Date())
        
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        
        var weekStr = ""
        switch comps.weekday! - 1 {
        case 1:
            weekStr = "星期一"
        case 2:
            weekStr = "星期二"
        case 3:
            weekStr = "星期三"
        case 4:
            weekStr = "星期四"
        case 5:
            weekStr = "星期五"
        case 6:
            weekStr = "星期六"
        case 7:
            weekStr = "星期日"
        default:
            print("")
        }
        return timeStr + "\(weekStr)"
    }
    
}
