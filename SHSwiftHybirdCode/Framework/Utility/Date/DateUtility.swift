//
//  DateUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/21.
//

import Foundation

class DateUtility {
    
    public static func getCurrentTimeInTravael() -> TimeInterval {
        return Date().timeIntervalSince1970
    }
    
    public static func dateStringToDate(dateFormat: String, dateString: String) -> Date? {
        
        let dateFormatterIn = DateFormatter()
        dateFormatterIn.dateFormat = dateFormat
        
        return dateFormatterIn.date(from: dateString) ?? nil
    }
    
    public static func dateToDateString(dateFormat: String, date: Date) -> String {
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = dateFormat
        return dateFormatterOut.string(from: date)
    }
    
    public static func getCurrentDateTimeStringWithStandardSQLiteDateTimeFromatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    public static func getCurrentDateTimeMillisecondString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return dateFormatter.string(from: Date())
    }
    
    public static func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    public static func getCurrentDateTimeMillisecondString(connection: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy\(connection)MM\(connection)dd\(connection)HH\(connection)mm\(connection)ss\(connection)SSS"
        return dateFormatter.string(from: Date())
    }
    
    public static func getWeedayFromeDate(date: Date) -> String {
        let calendar = Calendar.current
        let dateComponets = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.weekday,Calendar.Component.day], from: date)
     
        let weekDay = dateComponets.weekday
        switch weekDay {
        case 1:
           return "7"
        case 2:
          return  "1"
        case 3:
           return "2"
        case 4:
           return "3"
        case 5:
           return "4"
        case 6:
           return "5"
        case 7:
           return "6"
        default:
           return ""
        }
    }
    
    public class func compareCurrntTime(timeStamp: String) -> String {
       
        let interval:TimeInterval=TimeInterval(timeStamp)!
        let date = Date (timeIntervalSince1970: interval)
        var timeInterval = date.timeIntervalSinceNow

        timeInterval = -timeInterval

        if interval < 60 {
            return "just now"
        }
        else if Int(timeInterval/60) < 60 {

            return "before \(Int(timeInterval/60)) minutes"
        }
        else if Int((timeInterval/60)/60) < 24 {
            
            return "before \(Int((timeInterval/60)/60)) hours"
        
        }
        else{
        
          let dateformatter = DateFormatter()
          dateformatter.dateFormat="yyyy-MM-dd HH:mm:ss"
          return dateformatter.string(from: date as Date)
        }
    }
}
