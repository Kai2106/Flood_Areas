//
//  AppLog.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import Foundation

enum AppLogEvent: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
}

func print(_ object: Any) {
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print(object)
    #endif
}

final class AppLog {
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    class func e(_ object: Any,// The debug object which is to be printed on the debug console
                        filename: String = #file, // The file name from where the log will appear
                        line: Int = #line, // The line number of the log message
                        column: Int = #column, // The column number of the log message
                        funcName: String = #function) // The default value of this parameter is the signature of the function from where the log function is getting called.
    {
        print("\(Date().toString(format: dateFormat)) \(AppLogEvent.e.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    class func i(_ object: Any,
                        filename: String = #file,
                        line: Int = #line,
                        column: Int = #column,
                        funcName: String = #function) {
        print("\(Date().toString(format: dateFormat)) \(AppLogEvent.i.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    class func d(_ object: Any,
                        filename: String = #file,
                        line: Int = #line,
                        column: Int = #column,
                        funcName: String = #function) {
        print("\(Date().toString(format: dateFormat)) \(AppLogEvent.d.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        
    }
    
    class func v(_ object: Any,
                        filename: String = #file,
                        line: Int = #line,
                        column: Int = #column,
                        funcName: String = #function) {
        print("\(Date().toString(format: dateFormat)) \(AppLogEvent.v.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    class func w(_ object: Any,
                        filename: String = #file,
                        line: Int = #line,
                        column: Int = #column,
                        funcName: String = #function) {
        print("\(Date().toString(format: dateFormat)) \(AppLogEvent.w.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    class func s(_ object: Any,
                        filename: String = #file,
                        line: Int = #line,
                        column: Int = #column,
                        funcName: String = #function) {
        
        print("\(Date().toString(format: dateFormat)) \(AppLogEvent.s.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
}




