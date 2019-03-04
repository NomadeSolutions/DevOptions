//
//  WelcomeViewController.swift
//  DevOptions
//
//  Created by sacot41 on 02/28/2019.
//  Copyright (c) 2019 sacot41. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {

    //MARK: - Views
    
    private var informationLabel: UILabel!
    private var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        title = NSLocalizedString("welcome.navigation_bar.title", comment: "")
        pageTag = "welcome"
        
        let contentView = UIView()
        view.addSubview(contentView)
        
        informationLabel = UILabel()
        informationLabel.text = NSLocalizedString("welcome.label.information", comment: "")
        informationLabel.numberOfLines = 0
        informationLabel.textAlignment = .center
        contentView.addSubview(informationLabel)
        
        
        settingsButton = UIButton(type: .system)
        settingsButton.setTitle(NSLocalizedString("welcome.button.settings", comment: ""), for: .normal)
        settingsButton.addTarget(self, action: #selector(onClickSettingsButton), for: .touchUpInside)
        contentView.addSubview(settingsButton)
        
        
        contentView.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(view.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.lessThanOrEqualTo(view.snp.bottom).offset(-20)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        informationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
        
        settingsButton.snp.makeConstraints { (make) in
            make.top.equalTo(informationLabel.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
    }


    // MARK: - User interaction
    
    @objc private func onClickSettingsButton() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

}

