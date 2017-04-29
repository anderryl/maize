//
//  DeviceCheck.swift
//  test
//
//  Created by Anderson, Todd W. on 3/26/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

import UIKit

public extension UIDevice {
    
    //returns the tile size in points for any particular device
    var width: Double {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return 1//"iPod Touch 5"
        case "iPod7,1":                                 return 2//"iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return 3//"iPhone 4"
        case "iPhone4,1":                               return 4//"iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return 5//"iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return 6//"iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return 170//"iPhone 5s"
        case "iPhone7,2":                               return 8//"iPhone 6"
        case "iPhone7,1":                               return 9//"iPhone 6 Plus"
        case "iPhone8,1":                               return 10//"iPhone 6s"
        case "iPhone8,2":                               return 11//"iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return 12//"iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return 170//"iPhone 7 Plus"
        case "iPhone8,4":                               return 14//"iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return 15//"iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return 16//"iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return 17//"iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return 18//"iPad Air"
        case "iPad5,3", "iPad5,4":                      return 19//"iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return 20//"iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return 21//"iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return 22//"iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return 23//"iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return 24//"iPad Pro"
        case "AppleTV5,3":                              return 25//"Apple TV"
        case "i386", "x86_64":                          return 100//"Simulator"
        default:                                        return 27
        }
    }
    
}

