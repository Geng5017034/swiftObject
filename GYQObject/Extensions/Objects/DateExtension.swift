//
//  DateExtension.swift
//  childrenStar
//
//  Created by gengyongqiang on 16/12/3.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit

extension Date {

    func exDateString(format:String) -> String {
        let fmtter = DateFormatter()
        fmtter.dateFormat = format
        return fmtter.string(from: self)
    }

}
