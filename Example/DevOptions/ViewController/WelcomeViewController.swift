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
    
    private var imageView: UIImageView!
    private var informationLabel: UILabel!
    private var passwordLabel: UILabel!
    private var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        title = NSLocalizedString("welcome.navigation_bar.title", comment: "")
        pageTag = "welcome"
        
        let contentView = UIView()
        view.addSubview(contentView)
        
        imageView = UIImageView(image: UIImage(named: "icon_index"))
        contentView.addSubview(imageView)
        
        informationLabel = UILabel()
        informationLabel.text = NSLocalizedString("welcome.label.information", comment: "")
        informationLabel.numberOfLines = 0
        informationLabel.textAlignment = .center
        informationLabel.textColor = UIColor(red: 73/255, green: 75/255, blue: 81/255, alpha: 1)
        contentView.addSubview(informationLabel)
        
        passwordLabel = UILabel()
        passwordLabel.text = NSLocalizedString("welcome.label.password", comment: "") + " 1234"
        passwordLabel.textAlignment = .center
        passwordLabel.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        passwordLabel.textColor = .white
        contentView.addSubview(passwordLabel)
        
        settingsButton = UIButton(type: .custom)
        settingsButton.backgroundColor = UIColor(red: 130/255, green: 190/255, blue: 65/255, alpha: 1)
        settingsButton.setTitle(NSLocalizedString("welcome.button.settings", comment: ""), for: .normal)
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.addTarget(self, action: #selector(onClickSettingsButton), for: .touchUpInside)
        settingsButton.layer.cornerRadius = 25
        contentView.addSubview(settingsButton)
        
        
        let offset: CGFloat = view.frame.size.height * 0.08
        contentView.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(view.snp.top).offset(offset)
            make.left.equalTo(view.snp.left).offset(offset)
            make.right.equalTo(view.snp.right).offset(-offset)
            make.bottom.lessThanOrEqualTo(view.snp.bottom).offset(-offset * 0.5)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        informationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(offset)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(informationLabel.snp.bottom).offset(offset * 0.5)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(50)
        }
        
        settingsButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(offset)
            make.left.equalTo(view.snp.left).offset(75)
            make.right.equalTo(view.snp.right).offset(-75)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(50)
        }
    }


    // MARK: - User interaction
    
    @objc private func onClickSettingsButton() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

}

