//
//  BaseNavigationController.swift
//  DevOptions_Example
//
//  Created by William-José Simard-Touzet on 2019-03-01.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
    }

}
