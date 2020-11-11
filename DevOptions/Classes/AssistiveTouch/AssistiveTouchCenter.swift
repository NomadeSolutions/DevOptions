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
    
    func setAssistiveTouchImage(_ image: UIImage) {
        XFAssistiveTouch.sharedInstance().navigationController.setAssistiveTouch(image)
    }
    
    // MARK: - XFXFAssistiveTouchDelegate
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .default
    }
    
    func imageForAssistiveTouch() -> UIImage {
        var image = UIImage(named: "icon_assistive_touch_dev", in: DevOptions.ResourcesBundle(), compatibleWith: nil)!
        if DevOptions.applicationType() == .staging {
            image = UIImage(named: "icon_assistive_touch_staging", in: DevOptions.ResourcesBundle(), compatibleWith: nil)!
        }else if DevOptions.applicationType() == .production {
            image = UIImage(named: "icon_assistive_touch_prod", in: DevOptions.ResourcesBundle(), compatibleWith: nil)!
        }
        return image
    }
    
    func numberOfItems(in viewController: XFATViewController) -> Int {
        return 4
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
            let item =  XFATItemView.innerItem(with: UIImage(named: "dev_icon_info", in: DevOptions.ResourcesBundle(), compatibleWith: nil)!, title: "Show Developer Options Page")
            return item
            
        case 3:
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
            DevOptions.showDevOptionsViewController()
            
        case 3:
            DevOptions.setDevModeActivated(false)
            break
            
        default:
            break
        }
    }
    

    // MARK - Private func
    
    fileprivate func showLanguageSelector() {
        if let visibleViewController = DevOptions.topViewController() {
            
            var style = UIAlertController.Style.actionSheet
            if UIDevice.current.userInterfaceIdiom == .pad {
                style = .alert
            }
            
            let alertController = UIAlertController(title: "Choose language", message: nil, preferredStyle: style)
            
            for language in DevOptions.configurations.supportedLanguages! {
                let language = language.lowercased()
                let action = UIAlertAction(title: language, style: .default, handler: { (action) in
                    Bundle.setLanguage(language)
                })
                alertController.addAction(action)
            }
            
            let keyAction = UIAlertAction(title: "Localized key", style: .default, handler: { (action) in
                Bundle.setLanguage(nil)
            })
            alertController.addAction(keyAction)
            
            /*let deviceLanguageAction = UIAlertAction(title: "Device language", style: .default, handler: { (action) in
                Bundle.setLanguage(Locale.preferredLanguages.first)
            })
            actionSheet.addAction(deviceLanguageAction)*/
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
            alertController.addAction(cancelAction)
            
            visibleViewController.present(alertController, animated: true, completion: nil)
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
