//
//  GYQObject.swift
//  seven
//
//  Created by gengyongqiang on 16/11/3.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit

extension NSObject {

    //MARK - storyboard
    fileprivate func getStoryboardWithName(name:String) -> UIStoryboard {

        let storyBoard = UIStoryboard(name:name,bundle:nil);
        return storyBoard;
    }

    public func getViewControllerforStoryboard(storyname:String,vcName:String) -> UIViewController {
        let storyBoard = self.getStoryboardWithName(name: storyname);
        let controller = storyBoard.instantiateViewController(withIdentifier: vcName);
        return controller
    }

    public class func getViewControllerforStoryboard(storyname:String,vcName:String) -> UIViewController {
        let storyBoard = UIStoryboard(name:storyname,bundle:nil);
        let controller = storyBoard.instantiateViewController(withIdentifier: vcName);
        return controller
    }


}


