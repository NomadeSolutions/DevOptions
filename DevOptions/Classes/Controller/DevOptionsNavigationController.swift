//
//  DevOptionsNavigationController.swift
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2019-02-27.
//  Copyright © 2019 Nomade Solutions Mobiles. All rights reserved.
//

import UIKit

internal class DevOptionsNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        rootViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                                                               target: self,
                                                                               action: #selector(dismissViewController))
        rootViewController.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], for: .normal)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let style = navigationItem.backBarButtonItem?.style {
            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: style, target: nil, action: nil)
        }
        super.pushViewController(viewController, animated: animated)
    }

    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default;
    }
}
