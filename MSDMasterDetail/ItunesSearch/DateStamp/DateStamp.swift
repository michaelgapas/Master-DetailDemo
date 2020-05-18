//
//  DateStamp.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/18/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation

class DateStamp {
    
    private let kDateStamp = "dateStamp"
    private let userDefaults = UserDefaults.standard
    
    func saveDateStamp() {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let strDate = dateFormatter.string(from: date)
    
        userDefaults.setValue(strDate, forKeyPath: kDateStamp)
        userDefaults.synchronize()
    }
    
    func getDateStamp() -> String? {
        if let dateStamp = userDefaults.value(forKey: kDateStamp) {
            return dateStamp as? String
        }
        return nil
    }
    
}
