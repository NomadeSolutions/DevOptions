//
//  DevOptions.swift
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2018-01-31.
//  Copyright © 2018 Nomade Solutions Mobiles. All rights reserved.
//

import UIKit
import DevOptionsObjc

@objc public enum ApplicationType: Int {
    case development, production
}

@objc public class DevOptionsConfigurations: NSObject {
    @objc public var defaultApplicationType: ApplicationType = .development
    @objc public var companyLogo: UIImage?
    @objc public var licencesLogo: UIImage?
    @objc public var companyWebsite: String?
    @objc public var licensesFileName: String!
    @objc public var password: String!
    @objc public var darkTintColor: UIColor!
    @objc public var lightTintColor: UIColor!
    @objc public var buildTextColor: UIColor!
    @objc public var buildBackgroundColor: UIColor!
    @objc public var supportedLanguages: [String]!
    @objc public var mainStoryboardName: String? = nil {
        didSet{
            Bundle.setMainStoryboardName(mainStoryboardName)
        }
    }
    
    public override init() {
        super.init()
        licensesFileName = "Pods-acknowledgements.plist"
        password = ""
        darkTintColor = UIColor(red: 134.0/255.0, green: 134.0/255.0, blue: 134.0/255.0, alpha: 1)
        lightTintColor = UIColor.white
        buildTextColor = UIColor.gray
        buildBackgroundColor = UIColor.clear
        supportedLanguages = ["fr", "en"]
    }
}

@objc public class DevOptions: NSObject {
    
    // MARK: - Private vars
    
    static private let kIsDevModeActivated = "kIsDevModeActivated"
    static private let kApplicationType = "kApplicationType"
    
    internal static var onBaseUrlsChangeBlock: (()->Void)?
    private static var onApplicationTypeChangeBlock: (()->Void)?
    internal static var configurations: DevOptionsConfigurations!
    
    // MARK: - Public vars
    
    /*Configurations*/
    @objc public static var baseUrls: [String] = [] {
        didSet{
            onBaseUrlsChangeBlock?()
        }
    }
    
    /*User*/
    @objc public static var userId: String? = nil
    
    // MARK: - Class funcs
    
    /**
     Call this method in AppDelegate's didFinishLaunchingWithOptions to configure DevOptions. It will show the DevOptions icon if necessary.
     
     - parameter baseUrls: The current base URLs
     - parameter onServerChange: The block to procede when the application's environment switches (optional). Example: Development -> Production or Production -> Development.
     */
    @objc public class func configure(_ configurations: DevOptionsConfigurations, baseUrls: [String], onServerChange: (()->Void)?) {
        self.configurations = configurations
        self.baseUrls = baseUrls
        self.onApplicationTypeChangeBlock = onServerChange
        
        if DevOptions.isDevModeActivated() {
            AssistiveTouchCenter.sharedInstance.showAssistiveTouch(true)
        } else {
            UserDefaults.standard.set(configurations.defaultApplicationType.rawValue, forKey: kApplicationType)
        }
    }
    
    
    @objc public class func isDevModeActivated() -> Bool {
        return UserDefaults.standard.bool(forKey: kIsDevModeActivated)
    }
    
    /**
     To activate or deactivate DevOptions.
     You do not need to call this method unless necessary.
     */
    @objc public class func setDevModeActivated(_ isActivated: Bool) {
        UserDefaults.standard.set(isActivated, forKey: kIsDevModeActivated)
        AssistiveTouchCenter.sharedInstance.showAssistiveTouch(isActivated)
        setApplicationType(configurations.defaultApplicationType)
    }
    
    @objc public class func applicationType() -> ApplicationType {
        return ApplicationType(rawValue: UserDefaults.standard.integer(forKey: kApplicationType))!
    }
    
    class func setApplicationType(_ applicationType: ApplicationType) {
        let currentApplicationType = DevOptions.applicationType()
        UserDefaults.standard.set(applicationType.rawValue, forKey: kApplicationType)
        if currentApplicationType != applicationType {
            onApplicationTypeChangeBlock?()
            AssistiveTouchCenter.sharedInstance.setAssistiveTouchImage(AssistiveTouchCenter.sharedInstance.imageForAssistiveTouch())
        }
    }
    
    class func showDevOptionsViewController() {
        if let topViewController = DevOptions.topViewController() {
            if !topViewController.isKind(of: DevOptionsViewController.self) {
                let navigationController = DevOptionsNavigationController(rootViewController: DevOptionsViewController())
                topViewController.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    
    /**
     - parameter from: The controller from where search begins (optional)
     - returns: The top controller that user sees
     */
    @objc public class func topViewController(from: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = from as? UINavigationController {
            return topViewController(from: nav.visibleViewController)
        }
        if let tab = from as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(from: selected)
            }
        }
        if let presented = from?.presentedViewController {
            return topViewController(from: presented)
        }
        return from
    }
    
    
    /**
     You can call this when the app needs to be restarted.
     For example, in order to change server configurations for a Parse server.
     */
    @objc public class func showRestartAlert() {
        var message = NSLocalizedString("DevOptions.alert.app_needs_to_restart_message_ACTIVATE", bundle: DevOptions.ResourcesBundle(), comment: "")
        
        if DevOptions.isDevModeActivated() {
            message = NSLocalizedString("DevOptions.alert.app_needs_to_restart_message_DEACTIVATE", bundle: DevOptions.ResourcesBundle(), comment: "")
        }
        
        let exitAppAlert = UIAlertController(title: NSLocalizedString("DevOptions.alert.app_needs_to_restart_title", bundle: DevOptions.ResourcesBundle(), comment: ""),
                                             message: message,
                                             preferredStyle: .alert)
        
        let resetAppAction = UIAlertAction(title: NSLocalizedString("DevOptions.alert.app_needs_to_restart_action_close_now", bundle: DevOptions.ResourcesBundle(), comment: ""), style: .destructive) {
            (alert) -> Void in
            //Home button pressed programmatically
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            //Terminaing app once it is in background
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                exit(EXIT_SUCCESS)
            })
        }
        
        exitAppAlert.addAction(resetAppAction)
        DevOptions.topViewController()?.present(exitAppAlert, animated: true, completion: nil)
    }
    
    /**
     You can call this when the user has been disconnected.
     */
    @objc public class func showUserDisconnectedAlert() {
        let userDisconnectedAlert = UIAlertController(title: NSLocalizedString("DevOptions.alert.user_disconnected_title", bundle: DevOptions.ResourcesBundle(), comment: ""),
                                                      message: NSLocalizedString("DevOptions.alert.user_disconnected_message", bundle: DevOptions.ResourcesBundle(), comment: ""),
                                             preferredStyle: .alert)
        
        let okAction = UIAlertAction(title:  NSLocalizedString("DevOptions.general.ok", bundle: DevOptions.ResourcesBundle(), comment: ""), style: .default, handler: nil)
        
        userDisconnectedAlert.addAction(okAction)
        DevOptions.topViewController()?.present(userDisconnectedAlert, animated: true, completion: nil)
    }
    
    // MARK: - Debuging
    
    @objc public class func formattedVersionBuild() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let appBundle = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        return String(format: "V%@(%@)", version, appBundle)
    }
    
    @objc public class func currentDeviceId() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    // MARK: - Bundle
    
    internal class func ResourcesBundle()-> Bundle {
        let bundle = Bundle(for: DevOptions.self)
        return Bundle(url: bundle.url(forResource: "DevOptions", withExtension: "bundle")!)!
    }
}

