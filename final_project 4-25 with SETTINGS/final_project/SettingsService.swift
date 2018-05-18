//
//  SettingsService.swift
//  final_project
//
//  Created by Nicolai Antonov on 4/30/17.
//  Copyright © 2017 Akshata Sastry. All rights reserved.
//

import Foundation
import UIKit

class SettingsService {
    class var sharedService : SettingsService{
        struct Singleton {
            static let instance = SettingsService()
        }
        return Singleton.instance
    }
    
    
    init() {}
    
    var backgroundColor : UIColor {
        get {
            var data: NSData? = UserDefaults.standard.object(forKey: "backgroundColor") as? NSData
            var returnValue: UIColor?
            if data != nil {
                returnValue = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? UIColor
            } else {
                returnValue = UIColor(white: 1, alpha: 1);
            }
            return returnValue!
        }
    set (newValue) {
        let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
        UserDefaults.standard.set(data, forKey: "backgroundColor")
        UserDefaults.standard.synchronize()
        }
    }
    
    
    
}
