//
//  DevOptionsToggleView.swift
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2019-02-27.
//  Copyright © 2019 Nomade Solutions Mobiles. All rights reserved.
//

import UIKit

protocol DevOptionsToggleViewDelegate {
    func optionToggleView(_ optionToggleView: DevOptionsToggleView, valueChangedFor value: Bool)
}

class DevOptionsToggleView: UIView {

    // MARK: - Public vars
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    var isOn: Bool = false {
        didSet {
            toggle.isOn = isOn
        }
    }
    var isEnabled: Bool = true {
        didSet {
            toggle.isEnabled = isEnabled
        }
    }
    var delegate: DevOptionsToggleViewDelegate?
    
    
    // MARK: - Private vars
    
    fileprivate var label: UILabel!
    fileprivate var toggle: UISwitch!
    fileprivate var separatorView: UIView!
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        self.addSubview(label)
        
        toggle = UISwitch()
        toggle.isOn = false
        toggle.addTarget(self, action: #selector(onValueChanged), for: .valueChanged)
        self.addSubview(toggle)
        
        self.separatorView = UIView()
        self.addSubview(separatorView)
        
        
        label.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(toggle.snp.left).offset(-20)
            make.bottom.lessThanOrEqualTo(self.snp.bottom)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        toggle.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.lessThanOrEqualTo(self.snp.bottom)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(50)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - User interaction
    
    @objc func onValueChanged() {
        delegate?.optionToggleView(self, valueChangedFor: toggle.isOn)
    }
}
