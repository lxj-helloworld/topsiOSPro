//
//  DateUtil.swift
//  TopsProSys
//
//  Created by 李天星 on 2018/11/16.
//  Copyright © 2018年 com.topscommmac01. All rights reserved.
//

import Foundation
import QorumLogs

public enum DateFormateType:String{
    case YMDHMS = "yyyy-MM-dd HH:mm:ss" //年月日时分秒 2019-01-01 12:00:00
    case YMDHM = "yyyy-MM-dd HH:mm"  // 年月日时分 2019-01-01 12:00
    case MDHM = "MM-dd HH:mm"  // 月日时分 01-01 12:00
    case YMD = "yyyy-MM-dd"  // 年月日 2019-01-01
    case MD = "MM-dd"  // 月日 2019-01
    case HMS = "HH:mm:ss" // 时分秒 12:00:00
    case HM = "HH:mm" // 时分 12:00
}

public class DateUtils: NSObject {
    
    /// 日期字符串转date
    ///
    /// - Parameter dateStr: 日期字符串
    /// - Returns: date
    public class func dateStringToDate(dateStr:String,type:DateFormateType = .YMD) ->Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = type.rawValue
        let date = dateFormatter.date(from: dateStr)
        return date!
    }
    
    //获取两日期之间天数差
    public class func dateDifference(start:String, end:String) -> Double {
        let endDate = dateStringToDate(dateStr:end)
        let startDate = dateStringToDate(dateStr:start)
        let interval = endDate.timeIntervalSince(startDate)
        return interval/86400
    }
    
    //获取当前日期
    public class func getCurrentDate() -> Date{
        let date = Date()
        return date
    }
    
    //获取当前时间
    public class func getCurrentTime() -> String{
        let nowDate = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: nowDate as Date)
    }
    
    //获取当前时间 到毫秒
    public static func getCurrentMillisecond() -> String{
        let nowDate = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return formatter.string(from: nowDate as Date)
    }
    
    //获取相对于当前时间之前几天或者之后几天的日期
    public class func getDateByDays(_ days : Int) -> Date {
        let date = Date(timeIntervalSinceNow: TimeInterval(days * 24 * 60 * 60))
        return date
    }
    
    //时间转字符串
    public class func getDateStr(_ dateIn:Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: dateIn)
        return date
    }
    
    public class func cutDateStr(_ str:String,_ type:DateFormateType)->String{
        var result = ""
        if str != ""{
            result = str.replacingOccurrences(of: "T", with: " ")
            result = DateUtils.dateStringToDate(dateStr: result,type:.YMDHMS).formatDate(format:type)
        }
        return result
    }
    
}
extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    public var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    public var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    //根据格式对日期进行格式化
    public func formatDate(format: DateFormateType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format.rawValue
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    //日期控件使用
    public static func getDate(dateStr: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    //日期控件使用
    public func getComponent(component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
    
    
}
