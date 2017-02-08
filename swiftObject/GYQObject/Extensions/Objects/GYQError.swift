//
//  GYQError.swift
//  seven
//
//  Created by gengyongqiang on 16/11/25.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit

private var mydescription:String = ""

extension NSError {

   private(set) var gyq_description:String {  //外部可读 内部可写
        get {
            return (objc_getAssociatedObject(self, &mydescription) as? String)!
        }
        set {
            objc_setAssociatedObject(self, &mydescription, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func gyq_makeDescription(msg:String) -> Void {

        self.gyq_description = msg;
    }
}
