//
//  DevOptionsViewController.swift
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2018-01-31.
//  Copyright © 2018 Nomade Solutions Mobiles. All rights reserved.
//

import UIKit

class DevOptionsViewController: UIViewController, DevOptionsToggleViewDelegate {
    
    // MARK: - Private vars
    
    fileprivate var scrollView: UIView!
    fileprivate var contentView: UIView!
    fileprivate var devModeToggleView: DevOptionsToggleView!
    fileprivate var applicationTypeSegmentedControl: UISegmentedControl!
    fileprivate var userIdItem: DevOptionsItemView!
    fileprivate var deviceItem: DevOptionsItemView!
    fileprivate var osItem: DevOptionsItemView!
    fileprivate var versionItem: DevOptionsItemView!
    fileprivate var phoneLanguageItem: DevOptionsItemView!
    fileprivate var urlsItem: DevOptionsItemView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        self.view.backgroundColor = .white
        self.title = NSLocalizedString("DevOptions.view_controller.navigation_bar.title", bundle: DevOptions.ResourcesBundle(), comment: "")
        
        scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        devModeToggleView = DevOptionsToggleView()
        devModeToggleView.title = NSLocalizedString("DevOptions.view_controller.toggle.dev_mode", bundle: DevOptions.ResourcesBundle(), comment: "")
        devModeToggleView.isOn = DevOptions.isDevModeActivated()
        devModeToggleView.delegate = self;
        contentView.addSubview(devModeToggleView)
        
        userIdItem = DevOptionsItemView(title: NSLocalizedString("DevOptions.view_controller.item.userId_title", bundle: DevOptions.ResourcesBundle(), comment: ""))
        userIdItem.content = DevOptions.userId
        contentView.addSubview(userIdItem)
        
        deviceItem = DevOptionsItemView(title: NSLocalizedString("DevOptions.view_controller.item.device_title", bundle: DevOptions.ResourcesBundle(), comment: ""))
        deviceItem.content = DevOptions.currentDeviceId()
        contentView.addSubview(deviceItem)
        
        osItem = DevOptionsItemView(title: NSLocalizedString("DevOptions.view_controller.item.os_title", bundle: DevOptions.ResourcesBundle(), comment: ""))
        osItem.content = UIDevice.current.systemVersion
        contentView.addSubview(osItem)
        
        versionItem = DevOptionsItemView(title: NSLocalizedString("DevOptions.view_controller.item.app_version_title", bundle: DevOptions.ResourcesBundle(), comment: ""))
        versionItem.content = DevOptions.formattedVersionBuild()
        contentView.addSubview(versionItem)
        
        phoneLanguageItem = DevOptionsItemView(title: NSLocalizedString("DevOptions.view_controller.item.phone_language_title", bundle: DevOptions.ResourcesBundle(), comment: ""))
        phoneLanguageItem.content = NSLocale.current.languageCode
        contentView.addSubview(phoneLanguageItem)
        
        var formatedUrls = ""
        for url in DevOptions.baseUrls {
            if url != DevOptions.baseUrls.first {
                formatedUrls += "\n"
            }
            formatedUrls += url
        }
        
        urlsItem = DevOptionsItemView(title: NSLocalizedString("DevOptions.view_controller.item.base_urls_title", bundle: DevOptions.ResourcesBundle(), comment: ""))
        urlsItem.content = formatedUrls
        self.view.addSubview(urlsItem)
        
        applicationTypeSegmentedControl = UISegmentedControl(items:
            [NSLocalizedString("DevOptions.view_controller.segmented_control.dev",
                               bundle: DevOptions.ResourcesBundle(), comment: ""),
             NSLocalizedString("DevOptions.view_controller.segmented_control.prod",
                               bundle: DevOptions.ResourcesBundle(), comment: "")])
        applicationTypeSegmentedControl.isEnabled = DevOptions.isDevModeActivated()
        applicationTypeSegmentedControl.selectedSegmentIndex = DevOptions.applicationType().rawValue
        applicationTypeSegmentedControl.addTarget(self, action: #selector(onChangeApplicationType), for: .valueChanged)
        self.view.addSubview(applicationTypeSegmentedControl)
        
        DevOptions.onBaseUrlsChangeBlock = {
            var formatedUrls = ""
            for url in DevOptions.baseUrls {
                if url != DevOptions.baseUrls.first {
                    formatedUrls += "\n"
                }
                formatedUrls += url
            }
            self.urlsItem.content = formatedUrls
        }
    
        
        let offset = 20
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView.snp.edges)
            make.width.equalTo(view.snp.width)
        }
        
        devModeToggleView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(offset + 10)
            make.left.equalTo(contentView.snp.left).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
        }
        
        userIdItem.snp.makeConstraints { (make) in
            make.top.equalTo(devModeToggleView.snp.bottom).offset(offset)
            make.left.equalTo(contentView.snp.left).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
        }
        
        deviceItem.snp.makeConstraints { (make) in
            make.top.equalTo(userIdItem.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
        }
        
        osItem.snp.makeConstraints { (make) in
            make.top.equalTo(deviceItem.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
        }
        
        versionItem.snp.makeConstraints { (make) in
            make.top.equalTo(osItem.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
        }
        
        phoneLanguageItem.snp.makeConstraints { (make) in
            make.top.equalTo(versionItem.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
        }
        
        urlsItem.snp.makeConstraints { (make) in
            make.top.equalTo(phoneLanguageItem.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
        }
        
        applicationTypeSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(urlsItem.snp.bottom).offset(offset)
            make.left.equalTo(contentView.snp.left).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
            make.bottom.equalTo(contentView.snp.bottom).offset(-offset)
        }
    }
    
    // MARK: - OptionToggleViewDelegate
    
    func optionToggleView(_ optionToggleView: DevOptionsToggleView, valueChangedFor value: Bool) {
        if optionToggleView == devModeToggleView {
            DevOptions.setDevModeActivated(value)
            applicationTypeSegmentedControl.isEnabled = value
        }
    }
    
    // MARK: - User interaction
    
    @objc func onChangeApplicationType() {
        if applicationTypeSegmentedControl.selectedSegmentIndex == 0 {
            DevOptions.setApplicationType(.development)
        } else {
            DevOptions.setApplicationType(.production)
        }
    }

}
