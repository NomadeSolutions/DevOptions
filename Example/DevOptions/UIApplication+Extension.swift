//
//  UIApplication+Extension.swift
//  DevOptions_Example
//
//  Created by William-José Simard-Touzet on 2019-02-28.
//  Copyright © 2019 Nomade Solutions Mobiles. All rights reserved.
//

import UIKit
import DevOptions

extension UIApplication {
    class func serverBaseUrl() -> String {
        if DevOptions.isDevModeActivated() {
            if DevOptions.applicationType() == .development {
                return "https://yourserver-dev.com"
            } else if DevOptions.applicationType() == .staging {
                return "https://yourserver-staging.com"
            }else if DevOptions.applicationType() == .production {
                return "https://yourserver-prod.com"
            }
        }
        return Bundle.main.object(forInfoDictionaryKey: "base_url_server") as! String
    }
    
    class func otherBaseUrl() -> String {
        if DevOptions.isDevModeActivated() {
            if DevOptions.applicationType() == .development {
                return "https://anotherserver-dev.com"
            } else if DevOptions.applicationType() == .staging {
                return "https://anotherserver-staging.com"
            }else if DevOptions.applicationType() == .production {
                return "https://anotherserver-prod.com"
            }
        }
        return Bundle.main.object(forInfoDictionaryKey: "base_url_other") as! String
    }
}
