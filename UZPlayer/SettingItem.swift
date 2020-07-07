//
//  SettingItem.swift
//  UZPlayerExample
//
//  Created by Nam Nguyen on 7/3/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import Foundation

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


