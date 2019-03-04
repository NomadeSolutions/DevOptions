//
//  SettingsViewController.swift
//  DevOptions_Example
//
//  Created by William-José Simard-Touzet on 2019-02-28.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import DevOptions

class ItemView: UIView {
    
    init(title: String, view: UIView) {
        super.init(frame: .zero)
        
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        addSubview(label)
        
        addSubview(view)
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        addSubview(separator)
        
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(20)
            make.left.equalTo(snp.left)
            make.right.equalTo(view.snp.left)
            make.bottom.equalTo(snp.bottom).offset(-20)
        }
        
        view.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(20)
            make.right.equalTo(snp.right)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(view.intrinsicContentSize.width)
        }
        
        separator.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SettingsViewController: UIViewController {

    //MARK: - Views
    
    var userButton: UIButton!
    var needToResetSwitch: UISwitch!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        title = NSLocalizedString("settings.navigation_bar.title", comment: "")
        pageTag = "settings"
        
        var text = NSLocalizedString("settings.button.user_login", comment: "")
        if SettingsCenter.shared().isConnected {
            text = NSLocalizedString("settings.button.user_logout", comment: "")
        }
        userButton = UIButton(type: .system)
        userButton.setTitle(text, for: .normal)
        userButton.addTarget(self, action: #selector(onClickUserButton), for: .touchUpInside)
        let userItem = ItemView(title: NSLocalizedString("settings.item.user", comment: ""), view: userButton)
        view.addSubview(userItem)
        
        needToResetSwitch = UISwitch()
        needToResetSwitch.setOn(SettingsCenter.shared().needsToReset, animated: true)
        needToResetSwitch.addTarget(self, action: #selector(onChangeNeedToReset), for: .valueChanged)
        let needToResetItem = ItemView(title: NSLocalizedString("settings.item.need_to_reset", comment: ""), view: needToResetSwitch)
        if SettingsCenter.shared().isConnected {
            needToResetSwitch.isEnabled = false
        }
        view.addSubview(needToResetItem)
        
        let endorsementView = EndorsementView()
        view.addSubview(endorsementView)
        
        userItem.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        needToResetItem.snp.makeConstraints { (make) in
            make.top.equalTo(userItem.snp.bottom)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        endorsementView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    // MARK: - User interaction
    
    @objc private func onClickUserButton() {
        var text = NSLocalizedString("settings.button.user_login", comment: "")
        if SettingsCenter.shared().isConnected {
            SettingsCenter.shared().logoutUser()
            userButton.setTitle(text, for: .normal)
            needToResetSwitch.isEnabled = true
            
        } else {
            SettingsCenter.shared().loginUser()
            text = NSLocalizedString("settings.button.user_logout", comment: "")
            userButton.setTitle(text, for: .normal)
            needToResetSwitch.setOn(false, animated: true)
            needToResetSwitch.isEnabled = false
        }
    }
    
    @objc private func onChangeNeedToReset() {
        SettingsCenter.shared().needsToReset = needToResetSwitch.isOn
    }

}
