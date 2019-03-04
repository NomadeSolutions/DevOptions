//
//  AssistiveTouchCenter.swift
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2018-02-06.
//  Copyright © 2018 Nomade Solutions Mobiles. All rights reserved.
//

import UIKit
import Toast_Swift
import DevOptionsObjc

class AssistiveTouchCenter: NSObject, XFXFAssistiveTouchDelegate {

    @objc static let sharedInstance: AssistiveTouchCenter = {
        let instance = AssistiveTouchCenter()
        return instance
    }()
    
    private override init() {
        super.init()
        XFAssistiveTouch.sharedInstance().delegate = self
    }
    
    @objc func showAssistiveTouch(_ show: Bool) {
        if show {
            XFAssistiveTouch.sharedInstance().show()
        } else {
            XFAssistiveTouch.sharedInstance().hide()
        }
    }
    
    // MARK: - XFXFAssistiveTouchDelegate
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .default
    }
    
    func imageForAssistiveTouch() -> UIImage {
        return DevOptions.configurations.assistiveTouchIcon
    }
    
    func numberOfItems(in viewController: XFATViewController) -> Int {
        return 3
    }
    
    func viewController(_ viewController: XFATViewController, itemViewAtPosition position: XFATPosition) -> XFATItemView {
        switch (position.index) {
            
        case 0:
            let item =  XFATItemView.innerItem(with: UIImage(named: "dev_icon_language", in: DevOptions.ResourcesBundle(), compatibleWith: nil)!, title: "Change language")
            return item
            
        case 1:
            let item =  XFATItemView.innerItem(with: UIImage(named: "dev_icon_tag", in: DevOptions.ResourcesBundle(), compatibleWith: nil)!, title: "Page tag")
            return item
            
        case 2:
            let item =  XFATItemView.innerItem(with: UIImage(named: "dev_icon_exit", in: DevOptions.ResourcesBundle(), compatibleWith: nil)!, title: "Exit developer mode")
            return item
            
        default:
            return XFATItemView.innerItem(with: nil, title: nil)
        }
    }
    
    func viewController(_ viewController: XFATViewController, didSelectedAtPosition position: XFATPosition) {
        XFAssistiveTouch.sharedInstance().navigationController.shrink()
        
        switch (position.index) {
            
        case 0:
            showLanguageSelector()
            break
            
        case 1:
            showVisiblePageTag()
            break
            
        case 2:
            DevOptions.setDevModeActivated(false)
            break
            
        default:
            break
        }
    }
    

    // MARK - Private func
    
    fileprivate func showLanguageSelector() {
        if let visibleViewController = DevOptions.topViewController() {
            let actionSheet = UIAlertController(title: "Choose language", message: nil, preferredStyle: .actionSheet)
            
            for language in DevOptions.configurations.supportedLanguages! {
                let language = language.lowercased()
                let action = UIAlertAction(title: language, style: .default, handler: { (action) in
                    Bundle.setLanguage(language)
                })
                actionSheet.addAction(action)
            }
            
            let keyAction = UIAlertAction(title: "localized key", style: .default, handler: { (action) in
                Bundle.setLanguage(nil)
            })
            actionSheet.addAction(keyAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
            actionSheet.addAction(cancelAction)
            
            visibleViewController.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    fileprivate func showVisiblePageTag() {
        if let visibleViewController = DevOptions.topViewController() {
            var view = visibleViewController.view
            if  visibleViewController.children.count > 0 {
                let childVC = visibleViewController.children[0]
                view = childVC.view
            }
            
            view?.makeToast(visibleViewController.pageTag ?? "Page tag not set for this page.")
        }
    }
}