//
//  GYQConstants.swift
//  childrenStar
//
//  Created by gengyongqiang on 16/11/27.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit

//MARK:system

func RESIZE_UI(a:CGFloat) -> CGFloat {

    let resize = (UIScreen.main.bounds.size.width/375) * a 
    return resize
}



struct GYQDevice {
    //判断是否是iPhone4
   static var isIPhone4:Bool {
        if UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) {
            var mainsize : CGSize?
            mainsize = UIScreen.main.currentMode?.size
            let is4 :Bool = CGSize(width: 640, height: 960).equalTo(mainsize!)
            return is4
        } else {
            return false
        }
    }

    //判断是否是iPhone5
    static var isIPhone5:Bool {
        if UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) {
            var mainsize : CGSize?
            mainsize = UIScreen.main.currentMode?.size
            let is4 :Bool = CGSize(width: 640, height: 1136).equalTo(mainsize!)
            return is4
        } else {
            return false
        }
    }
    //判断是否是iPhone6
    static var isIPhone6:Bool {
        if UIScreen.instancesRespond(to: #selector(getter: UIScreen.nativeBounds)) {
            if #available(iOS 8.0, *) {
                return CGSize(width: 375*2, height: 667*2).equalTo(UIScreen.main.nativeBounds.size)
            } else {
                // Fallback on earlier versions
                return false
            }
        } else {
            return false
        }
    }
    //是否iPhone6plus
    static var isIPhone6plus:Bool {

        if UIScreen.instancesRespond(to: #selector(getter: UIScreen.nativeBounds)) {
            if #available(iOS 8.0, *) {
                return CGSize(width: 414.000000*3, height: 736.000000*3).equalTo(UIScreen.main.nativeBounds.size)
            } else {
                // Fallback on earlier versions
                return false
            }
        } else {
            return false
        }
    }

    static var isIpad:Bool {
//        [UIDevice currentDevice] userInterfaceIdiom]
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        return false
    }

    static var isPhone4OrPad:Bool {
        if self.isIPhone4 || self.isIpad {
            return true
        }
        return false

    }
}
