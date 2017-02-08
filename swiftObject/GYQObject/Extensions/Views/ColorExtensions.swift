//
//  ColorExtensions.swift
//  seven
//
//  Created by gengyongqiang on 16/11/2.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     *  16进制 转 RGBA
     */
    class func gyq_rgbaColorFromHex(rgb:Int, alpha: CGFloat) ->UIColor {

        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: alpha)
    }

    /**
     *  16进制 转 RGB
     */
    class func gyq_rgbColorFromHex(rgb:Int) -> UIColor {

        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: 1.0)
        
    }


    class func gyq_rgbColorFromRgb(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {

       return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
}
