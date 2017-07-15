//
//  NSDate.swift
//  Weathered
//
//  Created by Samuel Eskenasy on 13/07/2017.
//  Copyright © 2017 Samuel Eskenasy. All rights reserved.
//

import Foundation

extension Date {
    func dayOfTheWeek() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        return dateformatter.string(from: self)
        
    }
}
