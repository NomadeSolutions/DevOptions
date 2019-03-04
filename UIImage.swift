//
//  UIImage.swift
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2019-02-28.
//

import Foundation

extension UIImage {
    
    convenience init?(asset name: String) {
        let podBundle = Bundle(for: DevOptions.self)
        
        /// A given class within your Pod framework
        guard let url = podBundle.url(forResource: "DevOptions",
                                      withExtension: "bundle") else {
                                        return nil
                                        
        }
        
        self.init(named: name,
                  in: Bundle(url: url),
                  compatibleWith: nil)
    }
}
