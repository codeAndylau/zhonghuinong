//
//  Method.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import Photos

/// 自定义log方法
///
/// - Parameters:
///   - message: 输出内容
///   - file: 文件
///   - method: 方法名
///   - line: 那一行
public func debugPrints<T>(_ items: T,file: String = #file,method: String = #function,line: Int = #line) {
    #if DEBUG
    print("[\((file as NSString).lastPathComponent)-第\(line)行-\(method)]: \(items)")
    #endif
}

/// 本地化字符串
///
/// - Parameters:
///   - text: 显示文本
///   - comment: 默认值
/// - Returns: 返回字符串
public func localized(_ text: String, comment: String = "") -> String {
    return NSLocalizedString(text, comment: comment)
}

/// 代码延迟运行
///
/// - Parameters:
///   - delayTime: 延时时间。比如：.seconds(5)、.milliseconds(500)
///   - qosClass: 要使用的全局QOS类（默认为 nil，表示主线程）
///   - closure: 延迟运行的代码
public func delay(by delayTime: TimeInterval, qosClass: DispatchQoS.QoSClass? = nil, closure: @escaping () -> Void) {
    let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : DispatchQueue.main
    dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: closure)
}

/// 判断是否有相册权限
///
/// - Returns: bool
public func isRightPhotoAlbum() -> Bool {
    let authStatus = PHPhotoLibrary.authorizationStatus()
    debugPrints("相册权限状态为---\(authStatus.rawValue)")
    if authStatus == .authorized {
        return true
    }else {
        return false
    }
}

/// 判断是否有相机权限
///
/// - Returns: bool
public func isRightCamera() -> Bool {
    let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    debugPrints("相机权限状态为---\(authStatus.rawValue)")
    if authStatus == .authorized {
        return true
    }else {
        return false
    }
    
}

/// 判断是否有麦克风权限
///
/// - Returns: bool
public func isRightMicrophone() -> Bool {
    let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
    debugPrints("麦克风权限权限状态为---\(authStatus.rawValue)")
    if authStatus == .authorized {
        return true
    }else {
        return false
    }
}

/// GCD定时器倒计时⏳
///   - timeInterval: 循环间隔时间
///   - repeatCount: 重复次数
///   - handler: 循环事件, 闭包参数： 1. timer， 2. 剩余执行次数
public func DispatchTimer(timeInterval: Double, repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->()) {
    if repeatCount <= 0 {
        return
    }
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    var count = repeatCount
    timer.schedule(wallDeadline: .now(), repeating: timeInterval)
    timer.setEventHandler(handler: {
        count -= 1
        DispatchQueue.main.async {
            handler(timer, count)
        }
        if count == 0 {
            timer.cancel()
        }
    })
    timer.resume()
}

/// GCD定时器循环操作
///   - timeInterval: 循环间隔时间
///   - handler: 循环事件
public func DispatchTimer(timeInterval: Double, handler:@escaping (DispatchSourceTimer?)->()) {
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    timer.schedule(deadline: .now(), repeating: timeInterval)
    timer.setEventHandler {
        DispatchQueue.main.async {
            handler(timer)
        }
    }
    timer.resume()
}

/// 获取字符串的 rect
///
/// - Parameters:
///   - text: 文字
///   - font: 字体
///   - size: 大小
/// - Returns: rect
public func getTextRectSize(text: String,font: UIFont,size: CGSize) -> CGRect {
    let attributes = [NSAttributedString.Key.font: font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let rect: CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    return rect
}

/// 改变一个lab的不同部分颜色
///
/// - Parameters:
///   - str: 文字
///   - label: lab
///   - color: color
///   - range: 段落
public func labelGradient(_ str: String, label: UILabel, font: UIFont, color: UIColor, range: NSRange) {
    let str = NSMutableAttributedString(string: str)
    str.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    str.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    label.attributedText = str
}

/// 密码由6-16数字和字母组合组成
///
/// - Parameter pasword: 密码
/// - Returns: bool
public func isPassword(pasword : String) -> Bool {
    //let pwd = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"
    let pwd = "^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{8,16}$"
    let regextestpwd = NSPredicate(format: "SELF MATCHES %@",pwd)
    if (regextestpwd.evaluate(with: pasword) == true) {
        return true
    }else{
        return false
    }
    
}

/// 11 位手机号码校验
///
/// - Returns: bool
public func isPhone(mobile: String) -> Bool {
    let phone = "^1[0-9]{10}$"
    let regextest = NSPredicate(format: "SELF MATCHES %@", phone)
    if regextest.evaluate(with: mobile) == true {
        debugPrints("手机校验成功")
        return true
    }else {
        debugPrints("手机校验失败--手机无效")
        return false
    }
}

/// 从字符串中提取数字
///
/// - Parameter str:
/// - Returns: 
public func getIntFromString(str:String) -> String {
    let scanner = Scanner(string: str)
    scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
    var number :Int = 0
    scanner.scanInt(&number)
    debugPrints("提取正确的号码---\(number)")
    return String(number)
}

/// 判断当前设备是否是ipad
///
/// - Returns: bool
public func isIPad() -> Bool {
    let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    return isIPad
}

/// 获取时间和星期
///
/// - Parameter date: 
/// - Returns:
public func getCurrentDayAndTime(_ format: String) -> String {
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

/// 获取当前星期
///
/// - Returns:
public func getCurrentWeek() -> String {
    let calendar: Calendar = Calendar(identifier: .gregorian)
    var comps: DateComponents = DateComponents()
    comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
    return (comps.weekday! - 1).description
}

/// 获取当前时间
///
/// - Parameter date:
/// - Returns: 
public func getCurrentDate(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = date
    return dateFormatter.string(from: Date())
}

/// 割圆角
///
/// - Parameters:
///   - view:
///   - radius:
public func clipsViewCorner(_ view: UIView, radius: Int) {
    let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = view.bounds
    maskLayer.path = path.cgPath
    view.layer.mask = maskLayer
}


/// 打电话
///
/// - Parameter phone: phonenumber
public func callUpWith(_ phone: String) {
    let number =  "telprompt://\(phone)"
    //自动打开拨号页面并自动拨打电话
    if let url = URL(string: number) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}


/// 字典转jsonString
///
/// - Parameter dict: 字典
/// - Returns: data
public func dictToJsonString(dict: [String: Any]) -> String {
    if !JSONSerialization.isValidJSONObject(dict) {
        return String()
    }
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let jsonString = String(data: data ?? Data(), encoding: String.Encoding.utf8)!
    return jsonString
}

public func dictToData(dict: [String: Any]) -> Data {
    
    if !JSONSerialization.isValidJSONObject(dict) {
        return Data()
    }
    debugPrints("是否---\(JSONSerialization.isValidJSONObject(dict))")
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    debugPrints("转换的data---\(data!)")
    return data!
}
