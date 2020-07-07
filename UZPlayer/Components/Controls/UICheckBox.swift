//
//  UICheckBox.swift
//  UZPlayerExample
//
//  Created by Nam Nguyen on 7/7/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import UIKit


open class UZCheckBox: UIButton {
    public override init(frame: CGRect) {
        super?.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super?.init(coder: coder)
    }
    
    public var checked: Bool {
        didSet {
            
        }
    }
}


// MARK: Private methods
public extension UZCheckBox {

}
