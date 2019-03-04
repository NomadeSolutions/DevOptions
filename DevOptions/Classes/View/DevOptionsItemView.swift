//
//  DevOptionsItemView.swift
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2019-02-27.
//  Copyright © 2019 Nomade Solutions Mobiles. All rights reserved.
//

import UIKit

class DevOptionsItemView: UIView {

    // MARK: - Public vars
    
    var content: String? = NSLocalizedString("DevOptions.general.not_availble", bundle: DevOptions.ResourcesBundle(), comment: "") {
        didSet{
            contentLabel.text = content ?? NSLocalizedString("DevOptions.general.not_availble", bundle: DevOptions.ResourcesBundle(), comment: "")
        }
    }
    
    // MARK: - Views
    
    fileprivate var titleLabel: UILabel!
    fileprivate var contentLabel: UILabel!
    fileprivate var separatorView: UIView!
    
    // MARK: - Life cycle
    
    init(title: String) {
        super.init(frame: .zero)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentLabel.textColor = .black
        contentLabel.text = content
        contentLabel.numberOfLines = 0
        addSubview(contentLabel)
        
        separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        addSubview(separatorView)
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
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
