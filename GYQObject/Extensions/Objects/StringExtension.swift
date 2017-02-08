//
//  StringExtension.swift
//  seven
//
//  Created by gengyongqiang on 16/12/1.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit

extension String {

    var length:Int {
        get {
            return self.characters.count
        } set {
            length = newValue
        }

    }
}
