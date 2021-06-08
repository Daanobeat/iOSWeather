//
//  Extensions.swift
//  IosWeather
//
//  Created by Daniel Marceta on 22.04.21.
//

import Foundation

extension Double {
    func formatDouble(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    func formatDate() -> String{
        let date = Date(timeIntervalSince1970: self)
        let df = DateFormatter()
        //df.dateFormat = "y-MM-dd H:m:ss.SSSS"
        df.dateFormat = "dd.MM.y H:00"
        
        return df.string(from: date)

    }
}
