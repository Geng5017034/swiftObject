//
//  NavigationBarExtentsion.swift
//  seven
//
//  Created by gengyongqiang on 16/11/3.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit

extension UINavigationBar {

    class func gyq_appearance(param:Dictionary<String,AnyObject>,barTintColor:UIColor,tintColor:UIColor) {

        let navBar = UINavigationBar.appearance();
        navBar.barTintColor = barTintColor;
        navBar.tintColor = tintColor;
        navBar.titleTextAttributes = param;
    }

}
