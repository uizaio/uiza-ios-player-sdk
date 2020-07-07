//
//  SettingItem.swift
//  UZPlayerExample
//
//  Created by Nam Nguyen on 7/3/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import UIKit
import FrameLayoutKit

public enum UZSettingTag: Int {
    case none = -1
    case timeshift = 101
    case speedRate = 103
    case stats = 105
    case quality = 107
    case audio = 109
}

public enum UZSettingType: Int {
    case normal = 0
    case array = 3
    case bool = 1
    case number = 2
}


class SettingItem: NSObject {
    fileprivate(set) var title : String = ""
    fileprivate(set) var tag: UZSettingTag = .none
    fileprivate(set) var type: UZSettingType = .normal
    open var initValue: Any?
    
    init(title: String = "", tag: UZSettingTag, type: UZSettingType = .normal, initValue : Any? = nil) {
        super.init()
        self.title = title
        self.tag = tag
        self.type = type
        self.initValue = initValue
    }
    
}

class SettingTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor =  UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let summaryLabel:UILabel = {
        let label = UILabel()
        label.textColor =  UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
      return view
    }()
    
    func initViews() {
//        containerView.addSubview(HStackLayout {
//            ($0 + titleLabel).flexible()
//            $0 + summaryLabel
//            $0.spacing = 10
//        })
        containerView.addSubview(titleLabel)
        containerView.addSubview(summaryLabel)
        self.contentView.addSubview(containerView)
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:46).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        // summary
        summaryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        summaryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//        self.tintColor = UIColor.red

    }
}
