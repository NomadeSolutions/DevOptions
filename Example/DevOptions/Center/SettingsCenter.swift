//
//  SettingsCenter.swift
//  DevOptions_Example
//
//  Created by William-José Simard-Touzet on 2019-02-28.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import DevOptions

class SettingsCenter: NSObject {

    // MARK: - Singleton
    
    static let sharedInstance: SettingsCenter = {
        let instance = SettingsCenter()
        return instance
    }()
    
    class func shared() -> SettingsCenter {
        return sharedInstance
    }
    
    private override init() {
        super.init()
    }
    
    // MARK - Public vars
    
    var isConnected: Bool {
        get{
            let value =  UserDefaults.standard.bool(forKey: "isConnected")
            if value { DevOptions.userId = "1" }
            return value
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isConnected")
        }
    }
    var needsToReset: Bool {
        get{
            return UserDefaults.standard.bool(forKey: "needsToReset")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "needsToReset")
        }
    }
    
    
    // MARK: - Public funcs
    
    func loginUser() {
        isConnected = true
        DevOptions.userId = "1"
    }
    
    func logoutUser() {
        isConnected = false
        DevOptions.userId = nil
    }
}
