//
//  Date+Extensions.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import UIKit

extension Date {
    
    static var millisecondTimestamp: Int {
        return Int(CACurrentMediaTime() * 1000)
    }
    
    func toString(format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
}
