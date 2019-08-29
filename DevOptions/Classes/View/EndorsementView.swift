//
//  Endorsement.swift
//  DevOptions
//
//  Created by Samuel Cote on 2016-09-07.
//  Copyright © 2016 Nomade Solutions Mobiles. All rights reserved.
//

import UIKit
import SafariServices
import SnapKit
import TRZSlideLicenseViewController


@objc public class EndorsementView : UIView {
    
    // MARK: - Static var
    
    @objc public static let height: CGFloat = 110
    
    // MARK: - Views
    
    private var companyButton = UIButton()
    private var licenceButton = UIButton()
    private var buildLabel = UILabel()
    
    // MARK: - Controllers
    
    private var licenceVC:TRZSlideLicenseViewController? = nil
    private var devOptionsVC: DevOptionsViewController? = nil
    private var devModeAlertView: UIAlertController? = nil
    
    // MARK: - Gestures
    
    private var companyButtonLongPressedGesture:UILongPressGestureRecognizer! = nil
    private var licenceButtonLongPressdGesture:UILongPressGestureRecognizer! = nil
    private var companyButtonLongPresseTime = NSNumber()
    private var licenceButtonLongPresseTime = NSNumber()
    
    // MARK: - Files
    
    private var licenceFileName = DevOptions.configurations.licensesFileName
    
    
    // MARK: - Life cycle
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let contentView = UIView()
        addSubview(contentView)
        
        let companyImage = DevOptions.configurations.companyLogo
        self.companyButton.addTarget(self, action: #selector(onClickCompanyButton(sender:)), for: .touchUpInside)
        self.companyButton.setImage(companyImage, for: .normal)
        contentView.addSubview(self.companyButton)
        
        var licenceButtonImage = UIImage(named: NSLocalizedString("DevOptions.image.software_licenses", bundle: DevOptions.ResourcesBundle(), comment: ""), in: DevOptions.ResourcesBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        if let image = DevOptions.configurations.licencesLogo {
            licenceButtonImage = image
        } else {
             self.licenceButton.tintColor = DevOptions.configurations.darkTintColor
        }
        
        self.licenceButton.addTarget(self, action: #selector(onClickLicenseButton(sender:)), for: .touchUpInside)
        self.licenceButton.setImage(licenceButtonImage, for: .normal)
        self.licenceButton.contentMode = .center
        self.licenceButton.imageView?.contentMode = .center
        contentView.addSubview(self.licenceButton)
        
        self.companyButtonLongPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(onLongPresse(sender:)))
        self.companyButton.addGestureRecognizer(self.companyButtonLongPressedGesture)
        
        self.licenceButtonLongPressdGesture = UILongPressGestureRecognizer(target: self, action: #selector(onLongPresse(sender:)))
        self.licenceButton.addGestureRecognizer(self.licenceButtonLongPressdGesture)

        self.buildLabel.text = DevOptions.formattedVersionBuild()
        self.buildLabel.font = UIFont(name: self.buildLabel.font.fontName, size: 10)
        self.buildLabel.textAlignment = NSTextAlignment.center
        self.buildLabel.baselineAdjustment = .alignCenters
        self.buildLabel.textColor = DevOptions.configurations.buildTextColor
        self.buildLabel.backgroundColor = DevOptions.configurations.buildBackgroundColor
        contentView.addSubview(self.buildLabel)
        
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.companyButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.centerX)
            make.height.greaterThanOrEqualTo(44)
        }
        
        self.licenceButton.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.centerX)
            make.right.equalTo(contentView.snp.right)
            make.centerY.equalTo(self.companyButton.snp.centerY)
            make.height.greaterThanOrEqualTo(44)
        }
        
        self.buildLabel.snp.makeConstraints {(make) in
            make.top.equalTo(self.companyButton.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
            if DevOptions.configurations.buildBackgroundColor != .clear {
               make.height.equalTo(44)
            }
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: EndorsementView.height))
    }
    
    // MARK: - User interaction
    
    @objc private func onLongPresse(sender: NSObject) {
        
        if (sender == self.companyButtonLongPressedGesture) {
            self.companyButtonLongPresseTime = NSNumber.init(value: CFAbsoluteTimeGetCurrent() * 1000)
        } else if (sender == self.licenceButtonLongPressdGesture) {
            self.licenceButtonLongPresseTime = NSNumber.init(value: CFAbsoluteTimeGetCurrent() * 1000)
        }
        
        if (fabs(self.licenceButtonLongPresseTime.doubleValue - self.companyButtonLongPresseTime.doubleValue) < 100 && devModeAlertView == nil && devOptionsVC == nil) {
            
            if DevOptions.isDevModeActivated() {
                self.devOptionsVC = DevOptionsViewController()
                openDevOptionsViewController()
            
            } else {
                devModeAlertView = UIAlertController(title: NSLocalizedString("DevOptions.endorsement.alert.dev_options_title", bundle: DevOptions.ResourcesBundle(), comment: ""),
                                                     message: NSLocalizedString("DevOptions.endorsement.alert.dev_options_message", bundle: DevOptions.ResourcesBundle(), comment: ""),
                                                     preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("DevOptions.general.ok", bundle: DevOptions.ResourcesBundle(), comment: ""), style: .default, handler: { (action) in
                    let textfields = self.devModeAlertView!.textFields
                    let passwordField = textfields?[0]
                    
                    if passwordField?.text == DevOptions.configurations.password {
                        self.devOptionsVC = DevOptionsViewController()
                        self.openDevOptionsViewController()
                    }
                    
                    self.devModeAlertView = nil
                })
                
                self.devModeAlertView!.addAction(okAction)
                self.devModeAlertView!.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = NSLocalizedString("DevOptions.endorsement.alert.dev_options_password_placeholder", bundle: DevOptions.ResourcesBundle(), comment: "")
                    textField.isSecureTextEntry = true
                })
                
                DevOptions.topViewController()?.present(self.devModeAlertView!, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func onClickCompanyButton(sender: UIButton) {
        guard let website = DevOptions.configurations.companyWebsite else {return}
        if let url = URL(string: website) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            DevOptions.topViewController()?.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc private func onClickLicenseButton(sender: UIButton) {
        self.licenceVC = TRZSlideLicenseViewController()
        self.licenceVC!.title = NSLocalizedString("DevOptions.endorsement.licenses_title", bundle: DevOptions.ResourcesBundle(), comment: "")
        self.licenceVC!.podsPlistName = self.licenceFileName
        self.licenceVC!.headerType = TRZSlideLicenseViewHeaderType.none
        self.licenceVC!.footerType = TRZSlideLicenseViewFooterType.none
        
        let licenceNC = DevOptionsNavigationController(rootViewController: self.licenceVC!)
        DevOptions.topViewController()?.present(licenceNC, animated:  true, completion: nil)
    }
    
    // MARK: - Private funcs
    
    private func openDevOptionsViewController() {
        if self.devOptionsVC == nil { self.devOptionsVC = DevOptionsViewController() }
        let navigationController = DevOptionsNavigationController(rootViewController: self.devOptionsVC!)
        DevOptions.topViewController()?.present(navigationController, animated: true, completion: {
            self.devOptionsVC = nil
        })
    }
}
