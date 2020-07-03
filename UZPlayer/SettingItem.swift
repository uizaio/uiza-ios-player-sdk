//
//  SettingItem.swift
//  UZPlayerExample
//
//  Created by Nam Nguyen on 7/3/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import Foundation

class SettingItem: NSObject {
    var title : String?
    var tag: UZSettingTag = UZSettingTag.none
    var toggle: Bool = false
    open var toggleOn: Bool = false
    
    init(title: String?, tag: UZSettingTag, toggle: Bool = false, toggleOn : Bool = false) {
        super.init()
        self.title = title
        self.tag = tag
        self.toggle = toggle
        self.toggleOn = toggleOn
    }
}
